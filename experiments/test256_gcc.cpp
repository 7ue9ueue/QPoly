#include <immintrin.h>
#include <iostream>
#include <vector>
#include <chrono>
#include <random>
#include <iomanip>

#pragma GCC target("avx2")

using namespace std;
using vi = vector<int>;

void vector_add_baseline(const int* a, const int* b, int* result, int n) {
    for (int i = 0; i < n; i++) {
        result[i] = a[i] + b[i];
    }
}

// 8 ints × 4 bytes = 32 bytes = 256 bits
typedef int vec __attribute__((vector_size(32)));
// aligned(1) allows unaligned loads/stores (like loadu/storeu)
typedef int vec_u __attribute__((vector_size(32), aligned(1)));

void vector_add_SIMD(const int* a, const int* b, int* result, int n) {
    for (int i = 0; i < n; i += 8) {
        vec va = *(const vec_u*)(a + i);
        vec vb = *(const vec_u*)(b + i);
        vec vsum = va + vb;
        *(vec_u*)(result + i) = vsum;
    }
}

int main() {
    const int N = 4194304;
    const int NUM_RUNS = 100;
    const int NUM_DATASETS = 10;
    
    int x; cin >> x;
    mt19937 rng(x);
    uniform_int_distribution<int> dist(1, 1000000);
    
    vector<vi> a_datasets(NUM_DATASETS, vi(N));
    vector<vi> b_datasets(NUM_DATASETS, vi(N));
    vi result_baseline(N), result_simd(N);
    
    for (int d = 0; d < NUM_DATASETS; d++) {
        for (int i = 0; i < N; i++) {
            a_datasets[d][i] = dist(rng);
            b_datasets[d][i] = dist(rng);
        }
    }
    
    for (int i = 0; i < 5; i++) {
        vector_add_baseline(a_datasets[0].data(), b_datasets[0].data(), result_baseline.data(), N);
        vector_add_SIMD(a_datasets[0].data(), b_datasets[0].data(), result_simd.data(), N);
    }
    
    cout << "Testing vector addition with " << N << " elements (GCC)\n";
    cout << "Running " << NUM_RUNS << " iterations with " << NUM_DATASETS << " different datasets...\n\n";
    
    auto start = chrono::high_resolution_clock::now();
    for (int run = 0; run < NUM_RUNS; run++) {
        int dataset_idx = run % NUM_DATASETS;
        vector_add_baseline(a_datasets[dataset_idx].data(), b_datasets[dataset_idx].data(), result_baseline.data(), N);
    }
    auto end = chrono::high_resolution_clock::now();
    double baseline_time = chrono::duration<double, milli>(end - start).count();
    
    start = chrono::high_resolution_clock::now();
    for (int run = 0; run < NUM_RUNS; run++) {
        int dataset_idx = run % NUM_DATASETS;
        vector_add_SIMD(a_datasets[dataset_idx].data(), b_datasets[dataset_idx].data(), result_simd.data(), N);
    }
    end = chrono::high_resolution_clock::now();
    double simd_time = chrono::duration<double, milli>(end - start).count();
    
    bool correct = true;
    for (int d = 0; d < NUM_DATASETS; d++) {
        vector_add_baseline(a_datasets[d].data(), b_datasets[d].data(), result_baseline.data(), N);
        vector_add_SIMD(a_datasets[d].data(), b_datasets[d].data(), result_simd.data(), N);
        for (int i = 0; i < N; i++) {
            if (result_baseline[i] != result_simd[i]) {
                cout << "Mismatch at dataset=" << d << " i=" << i << ": " 
                     << result_baseline[i] << " vs " << result_simd[i] << endl;
                correct = false;
                break;
            }
        }
        if (!correct) break;
    }
    cout << "Correctness check: " << (correct ? "PASS" : "FAIL") << "\n\n";
    
    cout << "Total Baseline: " << fixed << setprecision(2) << baseline_time << " ms\n";
    cout << "Total SIMD:     " << simd_time << " ms\n";
    cout << "Speedup:        " << setprecision(2) << (baseline_time / simd_time) << "x\n\n";
    
    cout << "Per iteration:\n";
    cout << "Baseline: " << setprecision(3) << (baseline_time / NUM_RUNS) << " ms\n";
    cout << "SIMD:     " << (simd_time / NUM_RUNS) << " ms\n";
    
    cout << "\nChecksum: " << result_baseline[N/2] + result_simd[N/2] << endl;
    
    return 0;
}