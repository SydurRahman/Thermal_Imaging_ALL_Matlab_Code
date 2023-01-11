%Project by SYDUR RAHMAN, Fardeen Mahbub, and Rashedul Islam
%Supervised by Prof. Dr. Laurent Gallais, Assisted by Dr. Luis Vazquez-Zuniga
%Matlab Program for Image processing

clc;

file_name1='1200C-NA6.png';
file_name2='600C-NA6.png';
file_name3='1000C-NA6.png';

img1=double(imread(file_name1)); %%double(X) returns the double precision value for X.
img2=double(imread(file_name2)); %%double(X) returns the double precision value for X.
img3=double(imread(file_name3)); 

cal_data=calibration(img1);
colormap('hot')
imagesc(cal_data)
c = colorbar;
c.Label.String = 'Temperature in *C';



function img= calibration ( img )
L=size ( img );
for j =1:L(2)
    for i =1:L(1)
        ADU = img ( i , j ); 
        r=roots([2E-12 -9E-07 0.1531 21136-ADU]); %The calibration curve fitting
        l =1;  
        while l<4 
            fi=r ( l ); 
            if fi >=0 && fi <=300000 % lowest and highest possible roots for Total W
                x = fi ;
            else
                x=430; %For attenuation control to get room temperature 22 degree Celcius
            end
            l=l +1;
        end
                
        img ( i , j)=(nthroot ((abs(x)/(5.67E-8)),4)-273); %Only simple blackbody with emissivity=1 is considered
    end
end
end
