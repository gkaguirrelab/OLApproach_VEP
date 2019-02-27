function [LM1 S1 LM2 S2]=getMeanAdjust()

red_above=input('red above=');
red_below=input('red below=');

green_above=input('green above=');
green_below=input('green below=');

blue_above=input('blue above=');
blue_below=input('blue below=');

yellow_above=input('yellow above=');
yellow_below=input('yellow below=');

red=mean([red_above red_below]);
green=mean([green_above green_below]);

blue=mean([blue_above blue_below]);
yellow=mean([yellow_above yellow_below]);

LM1=mean([red green]);
S1=mean([blue yellow]);

red=min([red_above red_below]);
green=max([green_above green_below]);

blue=min([blue_above blue_below]);
yellow=max([yellow_above yellow_below]);

LM2=mean([red green]);
S2=mean([blue yellow]);

end