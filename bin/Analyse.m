N = length(Frame);
y = zeros(N-2,1);
x = 2:N-1;
for i = 2:N-1
    y(i-1) = Frame(i).NumAdsorp;
end
plot(x,y)
offset = 57;
time = x*0.5+offset;