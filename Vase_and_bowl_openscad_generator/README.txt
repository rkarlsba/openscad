                   .:                     :,                                          
,:::::::: ::`      :::                   :::                                          
,:::::::: ::`      :::                   :::                                          
.,,:::,,, ::`.:,   ... .. .:,     .:. ..`... ..`   ..   .:,    .. ::  .::,     .:,`   
   ,::    :::::::  ::, :::::::  `:::::::.,:: :::  ::: .::::::  ::::: ::::::  .::::::  
   ,::    :::::::: ::, :::::::: ::::::::.,:: :::  ::: :::,:::, ::::: ::::::, :::::::: 
   ,::    :::  ::: ::, :::  :::`::.  :::.,::  ::,`::`:::   ::: :::  `::,`   :::   ::: 
   ,::    ::.  ::: ::, ::`  :::.::    ::.,::  :::::: ::::::::: ::`   :::::: ::::::::: 
   ,::    ::.  ::: ::, ::`  :::.::    ::.,::  .::::: ::::::::: ::`    ::::::::::::::: 
   ,::    ::.  ::: ::, ::`  ::: ::: `:::.,::   ::::  :::`  ,,, ::`  .::  :::.::.  ,,, 
   ,::    ::.  ::: ::, ::`  ::: ::::::::.,::   ::::   :::::::` ::`   ::::::: :::::::. 
   ,::    ::.  ::: ::, ::`  :::  :::::::`,::    ::.    :::::`  ::`   ::::::   :::::.  
                                ::,  ,::                               ``             
                                ::::::::                                              
                                 ::::::                                               
                                  `,,`


http://www.thingiverse.com/thing:2150607
Vase and bowl openscad generator by bda is licensed under the Creative Commons - Attribution license.
http://creativecommons.org/licenses/by/3.0/

# Summary

Vase and bowl generator.
you can change parameters
accuracy =1;   // resolution in mm 
vase = 1;      // 1 for vase, 0 for candybowl
qty = 10;      // quantity of protrusion
tw  = 60;      // angle of twist
pvv = 0.82;    // part of sinusoid vertical 0.3-1.0 
pt  = 1.5;     // part of sinusoid for twist or 0 for linear
kv  = 0.6;     // koeff vertical < 1.0
kp  = 0.06;    // koeff protrusion < 0.5
and get own vase or bowl.
or you can change 
function fz(z)     = d/2+sin(pv*180*z/h)*kv*d/2;             // radius by height
function fy(angle) = sin(angle*qty)*kp*d/2;                  // radius by angle
function fx(z)     = ((pt==0)?1:sin(pt*180*z/h))*tw*z/h;     // twist: angle by height

function f(z,angle)= fz(z)+fy(angle+fx(z));
and create a new design.

openscad generate a big polygedron and working fast.
with resolution 1mm  render only  7sec and generate 130000 triangles.