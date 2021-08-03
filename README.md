# Dependency-matrix-based-fast-fault-diangosis
Dependency matrix is widely utilized in fault diangosis. However, its diagnotic efficiency will decrease significantly with the matrix size increasing. In this project, we regard the fault diangosis as a searching process, and we introduce the hash-based searching and binary tree searching to improve the diagnosis efficiency.
The code is implemented by MATLAB. There are two main files: vpa2accuracy and time_stat_en_bi. The first is to analyze the accuracy of the entropy-based knowledge, and the second is used to compute the time of the two methods.
The matrix size we firstly set is from 500 to 10000, and its running time is very long. The user can change the initial setting.
# Running result of vpa2accuracy.m
The vpa2accuracy.m has been executed, and it consumes about 50 hours. We have found the valid length of significant figures of entropy value.
# Running result of time_stat_en_bi.m
The time_stat_en_bi.m has been executed, and it consumes about 5 hours. The running time, average running time, and storage space of the hash-based method and binary search-based method have been obtained.
