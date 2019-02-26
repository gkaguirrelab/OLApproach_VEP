function [LMadjust Sadjust]=getMeanAdjust()

red_above=input('red above=');
red_below=input('red below=');

green_above=input('green above=');
green_below=input('green below=');

blue_above=input('blue above=');
blue_below=input('blue below=');

yellow_above=input('yellow above=');
yellow_below=input('yellow below=');

red=-1*mean([red_above red_below]);
green=mean([green_above green_below]);

blue=-1*mean([blue_above blue_below]);
yellow=mean([yellow_above yellow_below]);

LMadjust=mean([red green]);
Sadjust=mean([blue yellow]);

end