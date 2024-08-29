# Tracking-Frequency-Specific-Instantaneous-Brain-Connectivity-Dynamics-in-Resting-State-fMRI
Typical rs-fMRI studies measure brain functional connectivity (FC) and
brain networks based on calculating the correlations between fMRI time
series within a conventional frequency band, i.e., 0.01 to 0.1Hz. However,
these methods implicated assumptions of the temporal stationarity
throughout the measurement period, as well as lack frequency specificity
within this band.
However, there were numerous studies reported fMRI signal have
frequency-specific features. Furthermore, a considerable number of
studies have already investigated the "dynamic FC" and demonstrated the
importance temporal variation of FC. However, the parameters used to
segment fMRI signal were often chosen arbitrarily, and which limited the
generalizability and comparability across these studies.
The Hilbert Huang Transform (HHT) is an adaptive iterative algorithm
widely used in engineering. HHT decomposes signals into intrinsic mode
functions (IMFs) and define instantaneous phase, amplitude, and
frequency for each IMF. Therefore, we apply HHT on fMRI to achieve
adaptive frequency decomposition and high temporal resolution
synchronization measurements based on instantaneous phase difference.
![image](https://github.com/user-attachments/assets/502ff7e1-2b10-416f-9dcb-b205a48fb31a)<br />
Fig1. example of using HHT to process fMRI signals<br />
![image](https://github.com/user-attachments/assets/5531cd14-4314-4cb7-9ee4-858f7a798f57)<br />
Fig2. HWF distribution of IMFs produced produced by HHT process<br />
only if center frequency located between 0.01Hz and 0.1 Hz will we reserve the IMFs  <br />
![image](https://github.com/user-attachments/assets/5eec1993-c659-4794-8b10-a2bfef564826)<br />
Fig3. Based on clustering method, we identify 5 different feature brain states in each IMF.<br />
![image](https://github.com/user-attachments/assets/d9683de3-c9aa-4981-bd86-ea3ea86c8a3d)<br />
4.a IMF1 <br />
![image](https://github.com/user-attachments/assets/75b24402-48be-4c64-a43a-8d8997fd234a)<br />
4.b IMF2<br />
![image](https://github.com/user-attachments/assets/d0e5c9cd-7c39-4293-a6b4-0950419f8654)<br />
4.c IMF3<br />
Fig4. Projecting 246 ROI Atlas to yeo7 networks to visualize the funtional different brain states.<br />
