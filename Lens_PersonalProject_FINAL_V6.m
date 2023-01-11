%Project by Sydur Rahman, Fardeen Mahbub, and Rashedul Islam
%Supervised by Prof. Dr. Laurent Gallais, Assisted by Dr. Luis Vazquez-Zuniga
%Purpose- FAST PROGRAM FOR FOV, ANGULAR FOV, MAGNIFICATION, Sensor Position
%Purpose- Depth of Field, Depth of Focus, Resolution

%Input Dialog box code block START
prompt = {'Lens Type (Type- 1 for Convex/ 2 for Concave) :','Focal Length, F (in mm) : ','Sensor Image Plane size, H (in mm) : ', '(INPUT) Working Distance of Object from Lens, WD (in mm) : '};
dlgtitle = 'First Step: Camera Specifications Checking + Input - Rahman, Mahbub, Islam';
dims = [1 100];
definput = {'1','25.4','8.16',''}; %Pre-defined values
answer1 = inputdlg(prompt,dlgtitle,dims,definput);
%Input Dialog box code block END


%Assigning the User Input to the Processing Variables START
values = str2double(answer1);%Array of Values
lenstype = values(1); % Convex or Concave are assigned as numerical 1 and 2 respectively
F = values(2); %Focal distance
H = values(3); %Sensor_Height
WD = values(4); %Working Distance from Lens
%Assigning the User Input to the Processing Variables END


%Algorithm for the Processing START
%c = 0.017; %confusion circle as pixel size 17 micrometer
c= 0.017; %0.017 mm
s=0.017; %sensor pixel size
N = 1; % As the F-number is 1.  ==> N =  f/D where f=D for the LB7936-E3 Lens

FOV = (H*WD)/F; %Field of View 
AFOV = 2*atand((FOV)/(2*WD)); %Angular Field Of View
magnification = F/WD; % Magnification
v = (F*-WD)/(F+-WD); %Sensor positioning with the image plane
state = "Real Image"; %State
DOF = (2*N*c*WD*WD)/(F*F); %DEPTH OF FIELD
eff_fnum=(1+magnification)*N; %Effective f_number
DOFocus = 2*eff_fnum*c; %Depth of Focus

Res = s/magnification;%Resolution fast formula
%Algorithm for the Processing END




%Output Results Dialogue Box START
msg = sprintf("Field of View (FOV) or Object Size:  %0.2f mm \n\nAngular Field of View:  %0.2f Degrees \n\nMagnification: %0.2f\n(Warning! The formula used in here is best suitable magnification under 0.1)\n\nImage State: %s\n\n\nBest position of sensor from the Lens is around %0.2fmm (or %0.1fcm)\n\nThe Depth of Field (DOF-on Object plane): %0.2fmm\n\n Depth of focus (on image plane): %0.2fmm\n\n Resolution : %0.2f um",FOV,AFOV,magnification,state,v,v/10,DOF,DOFocus,Res);
txt = msgbox(msg);
%Output Results Dialogue Box END



%For Graphical Plots (Dear Dr. Prof. L. Gallais and Dr. Luis, we are not expert in Graphics, so we choose plotting to demonstrate the lens behaviour)

%Plotting Algorith START
x_origin = [0 0]; %Origin
x_obj = [-WD -WD]; %object position
x_img = [F F]; %Image position 
y_origin = [-(FOV+H)/2 +(H+FOV)/2]; %Just for beautification of plot
y_obj = [-FOV/2 +FOV/2]; %Object height
y_img = [-H/2 +H/2]; %Image height
x = [-(WD+WD/4) +(F+F/4)]; %X-axis (Beautification Purpose)
y = [0 0]; %Y-axis (Beautification Purpose)
x_objlens = [-WD 0]; %Object position at the left side of the lens
x_imglens = [0 +F]; %Image (Sensor) position of the right side of the lens
y_objlens1 = [+FOV/2 0]; %Beautification purpose
y_objlens2 = [-FOV/2 0]; %Beautification purpose 
y_imglens1 = [0 +H/2]; %Beautification purpose
y_imglens2 = [0 -H/2]; %Beautification purpose

x_DOF1 = [-WD-DOF -WD-DOF];
y_DOF1 = [-FOV/2 +FOV/2];
x_DOF2 = [-WD+DOF -WD+DOF];
y_DOF2 = [-FOV/2 +FOV/2];

x_DOFocus1 = [F-DOFocus/2 F-DOFocus/2];
y_DOFocus1 = [-H/2 +H/2];
x_DOFocus2 = [F+DOFocus/2 F+DOFocus/2];
y_DOFocus2 = [-H/2 +H/2];

%Figure code block start
figure(Name="Personal Project- Sydur Rahman, Rashedul Islam, Fardeen Mahbub");
plot(x_origin,y_origin,"-*k",x_obj,y_obj,"-*r",x_img,y_img,"-*b",x_objlens,y_objlens1,"-*g",x_objlens,y_objlens2,"-*g",x_imglens,y_imglens1,'-*y',x_imglens,y_imglens2,'-*y',x,y,"--k",x_DOF1,y_DOF1,'-k',x_DOF2,y_DOF2,'-k',x_DOFocus1,y_DOFocus1,'-k',x_DOFocus2,y_DOFocus2,'-k','Linewidth',1,'MarkerSize',1,'MarkerIndices',1:1:length(x))
xlim([-(WD+WD/4) +(F+F/4 +DOFocus)]); %limit on x-axis
ylim([-(FOV+H)/1.5 +(FOV+H)/1.5]); %limit on y-axis
legend('Lens','FOV (Object Height)','Sensor (Image)');
xlabel("Position");
set(findobj(gcf,'type','axes'),'FontName','Helvetica','FontSize',10,'FontWeight','Bold', 'LineWidth', 2)
%figure code block end

%Plotting Algorithm END
