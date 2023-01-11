%Project by Sydur Rahman, Fardeen Mahbub, and Rashedul Islam
%Supervised by Prof. Dr. Laurent Gallais, Assisted by Dr. Luis Vazquez-Zuniga
%Purpose- Beam Width

%Input Dialog box code block START
prompt = {'Beam Width at Laser Output, 2*W0 (in mm): ','Beam Full Divergence (mRad): ','Operating Wavelength (in um)', 'Distance at Lens Position (in mm) : ','Lens Focal Length (in mm) :'};
dlgtitle = 'M2 will be Auto calculated';
dims = [1 100];
definput = {'2.5','7','10.6','',''}; %Pre-defined values
answer1 = inputdlg(prompt,dlgtitle,dims,definput);
%Input Dialog box code block END

%Assigning the User Input to the Processing Variables START
values = str2double(answer1);%Array of Values
W0 = values(1)/2; % Beam waist at Laser output
theta0 = values(2)/2; %Half Divergence angle
Lambda = values(3); %Wavelength
Z = values(4); %Working Distance from Laser
f = values(5);
%Assigning the User Input to the Processing Variables END

M2 = (pi*theta0*W0)/Lambda; %M2 formula

W = W0*sqrt(1+((M2 * Lambda* Z*0.001)/(pi*W0*W0))^2); %Beam half-width Formula in mm
W0prime = (Lambda*f)/(pi*W*1000); %Beam Half width at focal plane in mm

RayLength = 1000* pi * W0prime^2 * (1/Lambda); %Rayleigh Length
theta = Lambda/(pi*W0prime); %New divergence



%Output Results Dialogue Box START
msg = sprintf("Beam Width at Focal plane for F = %0.2f mm Lens is : %0.3f mm \n New Beam Divergence %0.2f mrad\n New Rayleigh Length %0.3f mm",f,2*W0prime,2*theta,RayLength);
txt = msgbox(msg);
%Output Results Dialogue Box END

