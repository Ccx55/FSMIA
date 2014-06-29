function cdf = analyzeresidence(data_nFrame,data_count,expTime,totalTime)
% Residence time distribution analysis
% Input
%   DATA_NFRAME - Number of frames
%   DATA_COUNT - Number of molecules for the residence time
%   EXPTIME - Exposure time (second)
%   TOTALTIME - Length of the movie (second)
% Output
%
% Reference: Schwartz JACS (2011)

ind = find(data_count,1,'last');
count = data_count(1:ind);
tp = data_nFrame(1:ind)*expTime;
t = tp-expTime/2;
c = 1./(1-tp/totalTime);
nc = count.*c;
p = zeros(ind,1);
for i = 1:ind
    p(i) = sum(nc(i:end))/sum(nc);
end

cdf = struct;
cdf.t = t;
cdf.p = p;