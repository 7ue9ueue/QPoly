#include <immintrin.h>
#include <iostream>
#include <vector>
#include <chrono>
#include <random>
#include <iomanip>
using namespace std;
using vi = vector<int>;
vi vector_add_baseline(const vi& a, const vi& b, int n) {
    vi c(n);
    for (int i = 0; i < n; i++) {
        c[i] = a[i] + b[i];
    }
    return c;
}
typedef __m128i v4i;
typedef __m256i v8i;
typedef __m512i v16i;

vi vector_add_SIMD(const vi& a, const vi& b, int n) {
    vi result(n);
    for (int i=0;i+4<=n;i+=4) {
        v4i va = _mm_load_si128((v4i*)(&a[i]));
        v4i vb = _mm_load_si128((v4i*)(&b[i]));
        v4i vsum = _mm_add_epi32(va, vb);
        _mm_storeu_si128((v4i*)(&result[i]), vsum);
    }
    return result;
}

int main() {
    const int N = 4194304;  // 10 million elements
    const int NUM_RUNS = 10;
    
    // Initialize random generator
    int x; cin >> x;
    mt19937 rng(x);
    uniform_int_distribution<int> dist(1, 1000000);
    
    // Warmup
    vi warmup_a(N), warmup_b(N);
    for (int i = 0; i < N; i++) { warmup_a[i] = warmup_b[i] = i; }
    
    auto warmup_result0 = vector_add_baseline(warmup_a, warmup_b, N);
    auto warmup_result1 = vector_add_SIMD(warmup_b, warmup_a, N);
    cout << (warmup_result0[0] + warmup_result1[0]) << endl;
    
    cout << "Testing vector addition with " << N << " elements\n";
    cout << "Running " << NUM_RUNS << " iterations...\n\n";
    
    double total_baseline = 0.0;
    double total_simd = 0.0;
    
    for (int run = 0; run < NUM_RUNS; run++) {
        // Generate random data
        vi a(N), b(N);
        for (int i = 0; i < N; i++) {
            a[i] = dist(rng);
            b[i] = dist(rng);
        }
        
        // Baseline timing
        auto start = chrono::high_resolution_clock::now();
        vi result_baseline = vector_add_baseline(a, b, N);
        auto end = chrono::high_resolution_clock::now();
        double baseline_time = chrono::duration<double, milli>(end - start).count();
        total_baseline += baseline_time;
        
        // SIMD timing
        start = chrono::high_resolution_clock::now();
        vi result_simd = vector_add_SIMD(a, b, N);
        end = chrono::high_resolution_clock::now();
        double simd_time = chrono::duration<double, milli>(end - start).count();
        total_simd += simd_time;
        
        // Verify correctness
        bool correct = true;
        for (int i = 0; i < N; i++) {
            if (result_baseline[i] != result_simd[i]) {
                correct = false;
                break;
            }
        }
        
        cout << "Run " << setw(2) << (run + 1) << ": " << "Speedup = " << setw(5) << setprecision(2) << (baseline_time / simd_time) << endl;
    }
    
    double avg_baseline = total_baseline / NUM_RUNS;
    double avg_simd = total_simd / NUM_RUNS;
    
    cout << "Average Baseline: " << fixed << setprecision(5) << avg_baseline << " ms\n";
    cout << "Average SIMD:     " << avg_simd << " ms\n";
    cout << "Average Speedup:  " << setprecision(5) << (avg_baseline / avg_simd) << "x\n";
    
    return 0;
}