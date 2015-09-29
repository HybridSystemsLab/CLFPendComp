%postprocessing for the bouncing ball example


% plot solution                
figure(1)                      
clf                            
subplot(2,1,1),plotflows(t,j,x)
grid on                        
ylabel('x_1')                    
                               
subplot(2,1,2),plotjumps(t,j,x)
grid on                        
ylabel('x_1')                    
                 
figure(2)  
clf
subplot(2,1,1),plotflows(t,j,x(:,2))
grid on                        
ylabel('x_2')                    
                               
subplot(2,1,2),plotjumps(t,j,x(:,2))
grid on                        
ylabel('x_2') 

% plot hybrid arc  
plotHybridArc(t,j,x)           
xlabel('j')                    
ylabel('t')                    
zlabel('x_1')                    