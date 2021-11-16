
fullscale = 32767;

%t=0:3.2e-9:40e-6;                 % 40usec @ 312.5 MHz sample rate
t=0:10e-9:5.12e-6;                 % 40usec @ 312.5 MHz sample rate

if 0
I1=chirp(t,-25e6,25e-6,-20e6,'linear',0);       % Start @ -25 MHz, cross -20 MHz at t=15usec 
Q1=chirp(t,-25e6,25e-6,-20e6,'linear',90);       

I2=chirp(t,-15e6,25e-6,-10e6,'linear',0);       % Start @ -5 MHz, cross 5 MHz at t=15usec 
Q2=chirp(t,-15e6,25e-6,-10e6,'linear',90);       % Start @ -5 MHz, cross 5 MHz at t=15usec plus phase shift

I3=chirp(t,10e6,25e-6,15e6,'linear',0);       % Start @ -5 MHz, cross 5 MHz at t=15usec 
Q3=chirp(t,10e6,25e-6,15e6,'linear',90);       % Start @ -5 MHz, cross 5 MHz at t=15usec plus phase shift

I4=chirp(t,20e6,25e-6,25e6,'linear',0);       % Start @ -5 MHz, cross 5 MHz at t=15usec 
Q4=chirp(t,20e6,25e-6,25e6,'linear',90);       % Start @ -5 MHz, cross 5 MHz at t=15usec plus phase shift

a = round(fullscale*(I4));
b = round(fullscale*(Q4));

end

%t=0:50e-9:1;                 % 1 sec @ 20 MHz sample rate

%I=chirp(t,-80e6,40e-6,80e6,'linear',0);       % Start @ -80 MHz, cross 80 MHz at t=40 usec 
%Q=chirp(t,-80e6,40e-6,80e6,'linear',90);       % Start @ -80 MHz, cross 80 MHz at t=40 usec 

%I=chirp(t,-4e6,40e-6,4e6,'linear',0);       % Start @ -4 MHz, cross 4 MHz at t=40 usec 
%Q=chirp(t,-4e6,40e-6,4e6,'linear',90);       % Start @ -4 MHz, cross 4 MHz at t=40 usec 

I=chirp(t,5e6,5.12e-6,10e6,'linear',0);       % Start @ -4 MHz, cross 4 MHz at t=40 usec 
Q=chirp(t,5e6,5.12e-6,10e6,'linear',-90);       % Start @ -4 MHz, cross 4 MHz at t=40 usec 

a = round(fullscale*(I));
b = round(fullscale*(Q));

len = length(a)

if 0
fid = fopen('chirp.txt','w');
%fwrite(fid,a,'integer*2');
for i=1:len,
   %fprintf(fid,' %d, %d\n',a(i),b(i));
   fprintf(fid,'%d\n%d\n',a(i),b(i));
end;

fclose(fid);
end;

%plot(a);
%hold;
%plot(b,'r');

k = textread('px_axis_chirp_gen.sim\test_results.txt');
ki = k(1:2:length(k));
kq = k(2:2:length(k));
plot(ki);
hold;
plot(a,'r');


 