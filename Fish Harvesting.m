
format bank

rGrowth = input('What is fish rate of growth?')
carrCapac = input('What is the pond carrying capacity')
fCost = input('How much does it cost to purchase a fish?')
fixCost = input('What are your yearly fixed costs? Put 0 if none.')
hCost = input('How much does it cost to harvest a fish?')
fSale = input('How much revenue is earned per fish?')
capital = input('How much capital do you have available?')
time = input('For how many years would you like us to optimize your harvesting?')
scale = input('On a scale of 1 to 10 how precise do you want this estimate to be?')

%takes user's rate of growth and carrying capacity to create differential,
%solves the differential equation using 10000 h values lower than the
%carrying capacity



optHarvRate = 0;
optStart = 0;
optProf = 0; 
totalHarv = 0;


%Given a scale, tests 100*scale values for H and Initial Population
%betweeen 1 and the carrying capacity
    for i=1:(scale*100)
        for j=1:(scale*100)
            h = carrCapac/(scale*100)*i;
            initPop = carrCapac/(scale*100)*j;
 
            f=@(p,t)(rGrowth*p*(1-p/carrCapac)-h);
            [u,v]=ode45(f,[0 time],initPop);
            endPop = v(end);
            
            %total harvest for the given test, followed by revenue, 
            %cost, and profit
            
            harvest = h * time;
            rev = (fSale * harvest);
            cost = (fCost * initPop)+(hCost * harvest)+(fixCost*time);
            profit = rev - cost;
            disp('Calculating! This may take up to 2 minutes')

            %if we found a new optimal solution, mark optimal harvesting
            %rate and other relevant information
            if profit > optProf && capital <= cost && endPop>=0
                optProf = profit;
                optHarvRate = h;
                optStart = initPop;
                totalHarv =  harvest;
                end
       
           
        end
    end

                disp("Optimal Starting Population: ")
                disp(optStart)
                disp("Optimal annual harvest: ")
                disp(optHarvRate)
                disp("Total fish Harvested: ")
                disp(totalHarv)
                disp("Profit: ")
                disp(optProf)
    