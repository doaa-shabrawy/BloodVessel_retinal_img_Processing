function level = thresholdLevel(Image)
Image = im2uint8(Image(:));
[HistogramCount,BinNumber]=imhist(Image);
i=1;

CumulativeSum=cumsum(HistogramCount);
T(i)=(sum(BinNumber.*BinNumber))/CumulativeSum(end);
T(i)=round(T(i));

CumulativeSum2=cumsum(HistogramCount(1:T(i)));
MBT=sum(BinNumber(1:T(i)).*HistogramCount(1:T(i)))/CumulativeSum2(end);

CumulativeSum3=cumsum(HistogramCount(T(i):end));
MAT=sum(BinNumber(T(i):end).*HistogramCount(T(i):end))/CumulativeSum3(end);

i=i+1;
T(i)=round((MAT+MBT)/2);


while abs(T(i)-T(i-1))>=1
    
CumulativeSum2=cumsum(HistogramCount(1:T(i)));
MBT=sum(BinNumber(1:T(i)).*HistogramCount(1:T(i)))/CumulativeSum2(end);

CumulativeSum3=cumsum(HistogramCount(T(i):end));
MAT=sum(BinNumber(T(i):end).*HistogramCount(T(i):end))/CumulativeSum3(end);

i=i+1;
T(i)=round((MAT+MBT)/2);

Threshold=T(i);

end

level = (Threshold-1)/(BinNumber(end)-1);
end

