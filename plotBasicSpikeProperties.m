function plotBasicSpikeProperties(filepath)
% plot basic properties of kilosort/phy output
% modified from cortex-lab/neuropixels/Data Analysis: Getting Started Tutorial
% writtn by Ryo Aoki
% last updated@210601


[spikeTimes, spikeAmps, spikeDepths, spikeSites] = ksDriftmap(filepath);
figure; plotDriftmap(spikeTimes, spikeAmps, spikeDepths);


depthBins = 0:40:3840;
ampBins = 0:30:min(max(spikeAmps),800);
recordingDur = sp.st(end);

[pdfs, cdfs] = computeWFampsOverDepth(spikeAmps, spikeDepths, ampBins, depthBins, recordingDur);
plotWFampCDFs(pdfs, cdfs, ampBins, depthBins);

lfpD = dir(fullfile(filepath, '*.lf.bin')); % LFP file from spikeGLX specifically
lfpFilename = fullfile(filepath, lfpD(1).name);

lfpFs = 2500;  % neuropixels phase3a
nChansInFile = 385;  % neuropixels phase3a, from spikeGLX

[lfpByChannel, allPowerEst, F, allPowerVar] = ...
    lfpBandPower(lfpFilename, lfpFs, nChansInFile, []);

chanMap = readNPY(fullfile(filepath, 'channel_map.npy'));
nC = length(chanMap);

allPowerEst = allPowerEst(:,chanMap+1)'; % now nChans x nFreq

% plot LFP power
dispRange = [0 100]; % Hz
marginalChans = [10:50:nC];
freqBands = {[1.5 4], [4 10], [10 30], [30 80], [80 200]};

plotLFPpower(F, allPowerEst, dispRange, marginalChans, freqBands);







