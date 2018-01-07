clear;
czas=200;
K=1.4;
T1=1/14;
T2=100;
T3=10;
T4=1;
T0=25;
Tp=0.1;
m=menu('Menu','zmiana parametrÛw','pkt 1 odpowiedü skokowa','pkt 2 odpowiedü pulsowa','pkt 4 dobÛr Z-N','pkt PID','Koniec');
while (m~=6)
    switch m
        case 1
            prompt = {'czas','K','T1','T2','T3','T4','T0'};
            dlg_title = 'Input';
            num_lines = 1;
            defaultans = {'200','1.4','1/14','100','10','1','25'};
            answer = inputdlg(prompt,dlg_title,num_lines,defaultans);
            [czas, status]=str2num(answer{1});
            if ~status
                czas=200;
            end
            [K, status]=str2num(answer{2});
            if ~status
                K=1.4;
            end
            [T1, status]=str2num(answer{3});
            if ~status
                T1=1/14;
            end
            [T2, status]=str2num(answer{4});
            if ~status
                T2=100;
            end
            [T3, status]=str2num(answer{5});
            if ~status
                T3=10;
            end
            [T4, status]=str2num(answer{6});
            if ~status
                T4=1;
            end
            [T0, status]=str2num(answer{7});
            if ~status
                T0=25;
            end
        case 2
            FV=0; %amplituda drugiego wymuszenia skokowego
            sim('symulacja',czas);
            plot(tout, u ,'--', tout, y)
            title('Odpowiedü na wymuszenie skokowe u(t)=1(t-10)')
            grid on
            xlabel('t[s]')
            legend('wymuszenie u', 'odpowiedü y')
            print('pkt1','-dpng');
        case 3
            FV=1; %amplituda drugiego wymuszenia skokowego
            sim('symulacja',czas);
            plot(tout, u,'--', tout, y)
            title('Odpowiedü na wymuszenie skokowe u(t)=1(t-10)')
            grid on
            xlabel('t[s]')
            legend('wymuszenie u', 'odpowiedü y')
            print('pkt2','-dpng');
        case 4
            w=0;
            while(w==0)
                kin=inputdlg('Podaj wstÍpnie wartoúÊ wzmocnienia Kp:');
                Kk=str2num(kin{1});
                sim('symulacjaZN',czas);
                plot(tout, yout)
                xlabel('t[s]');
                ylabel('y');
                grid MINOR
                print('pkt4','-dpng');
                m1=menu('Sta≥e oscylacje?','Tak','Nie');
                switch m1
                    case 1
                        Tin=inputdlg('Okres oscylacji z wykresu=');
                        Tosc=str2num(Tin{1});
                        Kp=0.6*Kk;
                        Ti=0.5*Tosc;
                        Td=0.125*Tosc;
                        wiad=['Kp= ',num2str(Kp),' Ti= ',num2str(Ti),' Td= ',num2str(Td)];
                        disp(wiad);
                        w=1;
                    case 2
                        w=0;
                end
            end
            
        case 5
            kd=6;
            %zmiana parametrÛw PID
            prompt = {'Kp','Ti','Td'};
            dlg_title = 'Input';
            num_lines = 1;
            defaultans = {'0.3894','36','9'};
            answer = inputdlg(prompt,dlg_title,num_lines,defaultans);
            [Kp, status]=str2num(answer{1});
            if ~status
                Kp=0.3894;
            end
            [Ti, status]=str2num(answer{2});
            if ~status
                Ti=36;
            end
            [Td, status]=str2num(answer{3});
            if ~status
                Td=9;
            end
            
            m1=menu('Menu','5.1','5.2','5.3','5.4','koniec');
            while(m1~=5)
                czasPID=600;
                %skok z
                Tz=0;
                Az=0;
                %sinus z
                Asz=0;
                omz=0;
                fazaz=0;
                %skok y
                Ty=0;
                Ay=0;
                %sinus y
                Asy=0;
                omy=0;
                fazay=0;
                %skok 2 y
                Ty2=0;
                Ay2=0;
                %sinus 2 y
                Asy2=0;
                omy2=0;
                fazay2=0;
                switch m1
                    case 1
                        %skok y
                        Ty=10;
                        Ay=1;
                        tytul='yr(t)=1(t-10),z(t)=0';
                        nazwa='pkt5_1a';
                        nazwa2='pkt5_1b';
                    case 2
                        %skok z
                        Tz=100;
                        Az=0.2;
                        %skok y
                        Ty=10;
                        Ay=1;
                        tytul='yr(t)=1(t-10),z(t)=0.2*1(t-100)';
                        nazwa='pkt5_2a';
                        nazwa2='pkt5_2b';
                    case 3
                        %skok 2 y
                        Ty2=10;
                        Ay2=1;
                        %sinus 2 y
                        Asy2=1;
                        omy2=0.01;
                        fazay2=0;
                        tytul='yr(t)=sin(0.01t)*1(t-10),z(t)=0';
                        nazwa='pkt5_3a';
                        nazwa2='pkt5_3b';
                    case 4
                        %skok z
                        Tz=0;
                        Az=0.1;
                        %sinus z
                        Asz=-0.1;
                        omz=0.05;
                        fazaz=0;
                        %sinus y
                        Asy=1;
                        omy=0.05;
                        fazay=pi/2;
                        tytul='yr(t)=cos(0.05t),z(t)=0.1[1(t)-sin(0.05t)]';
                        nazwa='pkt5_4a';
                        nazwa2='pkt5_4b';
                end
                sim('symulacjaPID',czasPID);
                figure
                plot(tout, yr ,'--', tout, y)
                title(tytul);
                grid on
                xlabel('t[s]')
                legend('sygnal zadany yr', 'odpowiedü y')
                print(nazwa,'-dpng');
                
                figure
                plot(tout, ur ,'--', tout, z)
                title(tytul);
                grid on
                xlabel('t[s]')
                legend('sygna≥ sterujπcy ur', 'zak≥Ûcenia z')
                print(nazwa2,'-dpng');
                
                if(m1==1)%Obliczenia pkt6
                    e_min = abs(min(e));
                    e_max = abs(max(e));
                    e_m=max(e_min,e_max);
                    delta=0.05*e_m;
                    N=size(e);
                    N=N(1,1);
                    i=N;
                    j=1;
                    while (e(i)<delta && e(i)>-delta)
                        j=i;
                        i=i-1;
                    end
                    Tr=tout(j)-Ty % czas regulacji
                    suma=0;
                    for i=1:N
                        suma=suma+e(i,1);
                    end
                    e_sr=suma/N % sredni b≥πd regulacji
                    
                    suma=0;
                    for i=1:N
                        suma=suma+(e(i,1))^2;
                    end
                    e_sr2=suma*Tp % ca≥ka kwadratu b≥Ídu regulacji

                    suma=0;
                    for i=1:N
                        suma=suma+(ur(i,1))^2;
                    end
                    ur_en=suma*Tp % energia sterowaÒ
                 end
                 m1=menu('Menu','5.1','5.2','5.3','5.4','koniec');
            end
    end
    m=menu('Menu','zmiana parametrÛw','pkt 1 odpowiedü skokowa','pkt 2 odpowiedü pulsowa','pkt 4 dobÛr Z-N','pkt PID','Koniec');
end