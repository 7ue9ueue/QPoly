#include "generated.hpp"
#include <chrono>
#include <iostream>
#include <random>
#include <string>

using Clock=std::chrono::steady_clock;
constexpr uint32_t mod=998244353;
[[noreturn]] void fail(const char* name,const char* phase) {
    std::cerr<<"FAIL "<<name<<' '<<phase<<'\n';std::exit(1);
}
void check(const std::vector<uint32_t>& values, const std::string& text) {
    std::vector<char> input(text.begin(),text.end());input.resize(input.size()+64,0);
    std::string expected;
    for(auto x:values)expected+=' '+std::to_string(x);
    std::vector<uint32_t> parsed(values.size()+16,0xdeadbeef);
    std::vector<char> output(10*values.size()+64, '\x5a');
    for(const auto& entry:entries) {
        entry.read(input.data(),parsed.data(),values.size());
        if(!std::equal(values.begin(),values.end(),parsed.begin()))fail(entry.name,"parse");
        for(size_t i=values.size();i<parsed.size();++i)if(parsed[i]!=0xdeadbeef)fail(entry.name,"input guard");
        size_t bytes=entry.write(values.data(),values.size(),output.data(),output.size());
        if(bytes!=expected.size()||std::memcmp(output.data(),expected.data(),bytes))fail(entry.name,"format");
        // Partial leading groups deliberately store up to four bytes; reserve 16.
        for(size_t i=bytes+16;i<output.size();++i)if(output[i]!='\x5a')fail(entry.name,"output guard");
        std::fill(output.begin(),output.end(),'\x5a');
    }
}
int main(int argc,char** argv) {
    bool check_only=argc>1 && std::string(argv[1])=="--check";
    std::mt19937 rng(20260927);
    std::vector<uint32_t> edges{0,1,9,10,99,100,999,1000,9999,10000,99999,100000,
        999999,1000000,9999999,10000000,99999999,100000000,mod-1};
    // Every decimal value up to 200000 and all output digit-table entries.
    for(uint32_t i=0;i<=200000;++i)edges.push_back(i);
    std::string edge_text;
    for(auto x:edges)edge_text+=std::to_string(x)+" \r\n\t";
    check(edges,edge_text);
    // Every byte alignment and missing trailing delimiter on short/long numbers.
    for(unsigned pad=0;pad<32;++pad) {
        for(uint32_t x:{0u,9u,100u,12345678u,123456789u,mod-1}) {
            check({x},std::string(pad,' ')+std::to_string(x));
        }
    }
    std::cout<<"kind,pattern,n,variant,iteration,milliseconds\n";
    size_t checked=edges.size()+192;
    for(size_t n:{size_t(4096),size_t(1<<20)})for(int pattern=0;pattern<4;++pattern) {
        const char* label[]={"uniform","mixed_digits","zeros","max_residue"};
        std::vector<uint32_t> values(n);
        uint32_t powers[]={10,100,1000,10000,100000,1000000,10000000,100000000,mod};
        std::string expected;
        for(auto& x:values) {
            x=pattern==0?rng()%mod:pattern==1?rng()%powers[rng()%9]:pattern==2?0:mod-1;
            expected+=' '+std::to_string(x);
        }
        std::string input_text=expected.substr(1)+'\n';
        check(values,input_text);checked+=n;
        if(check_only)continue;
        std::vector<char> input(input_text.begin(),input_text.end());input.resize(input.size()+64,0);
        std::vector<uint32_t> parsed(n);
        std::vector<char> output(n*10+64);
        const int count=int(sizeof(entries)/sizeof(entries[0]));
        for(int rep=-2;rep<9;++rep)for(int k=0;k<count;++k) {
            const auto& e=entries[(k+(rep+2)*4)%count];
            auto t0=Clock::now();e.read(input.data(),parsed.data(),n);auto t1=Clock::now();
            if(parsed!=values)fail(e.name,"timed parse");
            auto t2=Clock::now();size_t bytes=e.write(values.data(),n,output.data(),output.size());auto t3=Clock::now();
            if(bytes!=expected.size()||std::memcmp(output.data(),expected.data(),bytes))fail(e.name,"timed format");
            if(rep>=0) {
                std::cout<<"parse,"<<label[pattern]<<','<<n<<','<<e.name<<','<<rep<<','
                    <<std::chrono::duration<double,std::milli>(t1-t0).count()<<'\n';
                std::cout<<"format,"<<label[pattern]<<','<<n<<','<<e.name<<','<<rep<<','
                    <<std::chrono::duration<double,std::milli>(t3-t2).count()<<'\n';
            }
        }
    }
    std::cerr<<"PASS "<<checked<<" values per variant; "<<sizeof(entries)/sizeof(entries[0])
             <<" variants; independent decimal strings, "
                "alignment, zero padding, guards, 1-9 digits and coefficient boundaries\n";
}
