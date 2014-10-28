function biImage = RoughScan(RawImage)
%%%%%Version 2%%%%%
% Add Gaussian smoothing, which could help single molecule object
% recognition.
global Option
threshold = Option.threshold;
R = Option.spotR;
% Gaussian smoothing to remove noisy outliers
h = fspecial('gaussian',7,1.1);
filteredImage = imfilter(RawImage,h,'symmetric');
[m,n] = size(filteredImage);
biImage = zeros(m,n);
for i = (R+1):(m-R)
    for j = (R+1):(n-R)
        if filteredImage(i,j) > threshold
            subImage = filteredImage(i-R:i+R,j-R:j+R);
            subImage(R+1,R+1) = 0;
            neighborMax = max(max(subImage));
            % If there are two adjacent maximum, only choose one
            if filteredImage(i,j) >= neighborMax && sum(sum(biImage(i-1:i+1,j-1:j+1))) < 0.5
                biImage(i,j) = 1;
            end
        end
    end
end
if Option.exclude
    x1 = Option.exclude(1,1);
    y1 = Option.exclude(1,2);
    x2 = Option.exclude(2,1);
    y2 = Option.exclude(2,2);
    biImage(x1:x2,y1:y2) = 0;
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%Version 1%%%%%
% global Option
% threshold = Option.threshold;
% R = Option.spotR;
% [m,n] = size(RawImage);
% biImage = zeros(m,n);
% for i = (R+1):(m-R)
%     for j = (R+1):(n-R)
%         if RawImage(i,j) > threshold
%             subImage = RawImage(i-2:i+2,j-2:j+2);
%             subImage(3,3) = 0;
%             neighborMax = max(max(subImage));
%             % If there are two adjacent maximum, only choose one
%             if RawImage(i,j) >= neighborMax && sum(sum(biImage(i-1:i+1,j-1:j+1))) < 0.5
%                 biImage(i,j) = 1;
%             end
%         end
%     end
% end
% if Option.exclude
%     x1 = Option.exclude(1,1);
%     y1 = Option.exclude(1,2);
%     x2 = Option.exclude(2,1);
%     y2 = Option.exclude(2,2);
%     biImage(x1:x2,y1:y2) = 0;
% end
