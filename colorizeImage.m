function Color_Img = colorizeImage(ResizedImg,ComplementedImg,ColorspaceDef)

DEFAULT_COLOR=[1 1 1];%%% white

if nargin <3 
    ColorspaceDef = DEFAULT_COLOR;

end

ComplementedImg = (ComplementedImg ~=0);
ResizedUint8 = im2uint8(ResizedImg);
ColorUint8 = im2uint8 (ColorspaceDef);

if ndims(ResizedUint8)==2

    Red_Channel = ResizedUint8;
    Green_Channel = ResizedUint8;
    Blue_Channel = ResizedUint8;

else
    Red_Channel = ResizedUint8(:,:,1);
    Green_Channel = ResizedUint8(:,:,2);
    Blue_Channel = ResizedUint8(:,:,3);
 
   
end
 Red_Channel(ComplementedImg)= ColorUint8(1);
 Green_Channel(ComplementedImg)= ColorUint8(2);
 Blue_Channel(ComplementedImg)= ColorUint8(3);



Color_Img = cat(3,Red_Channel,Green_Channel,Blue_Channel);
end





