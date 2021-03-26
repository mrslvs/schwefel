%task1
%isid92654
%Schwefel

space_down = ones(1,10) * -500; %lowest value
space_up = ones(1,10) * 500; %highest value
space = [space_down; space_up]; %space used to generate population
pop_size = 200;
vec_of_best_ones = [15, 10, 5]; %take 15x best, 10x second best, ...
num_of_cycles = 800;

%manual toggles for selection
selbest_toggle = 1;
seltourn_toggle = 0;
selsus_toggle = 0;
selrand_toggle = 0;
selection = get_selection(selbest_toggle, seltourn_toggle, selsus_toggle, selrand_toggle);

population = genrpop(pop_size,space); %generate population

fit_of_population = testfn3(population); %calculate fitness function
best_individuals = zeros(1,pop_size);

hold on
for i = 1:num_of_cycles
    best_individuals(i) = min(fit_of_population); %take best one for graph
    fit_of_population = testfn3(population); %fitness
    
    %how to select the best individuals
    switch selection
        case 1
            new_population = selbest(population, fit_of_population, vec_of_best_ones);
        case 2
            new_population = seltourn(population, fit_of_population, sum(vec_of_best_ones));
        case 3
            new_population = selsus(population, fit_of_population, sum(vec_of_best_ones));
        case 4
            new_population = selrand(population, fit_of_population, sum(vec_of_best_ones));
    end 
    
    %crossing
    population = crossov(population, 1, 0);
    
    %mutation
    population = mutx(population, 0.08, space);
    amp = ones(1,10) * 50;
    population = muta(population, 0.01, amp, space); 
    
    %merge best ones with randomly crossed and mutated individuals
    diff = (pop_size-(sum(vec_of_best_ones)));
    temp_pop = selrand(population, fit_of_population, diff);
    
    population = [new_population; temp_pop];
end

plot(best_individuals);

function sel = get_selection(best, tourn, sus, rand)
%returns:
%   1 for selbest    3 for selsus
%   2 for seltourn   4 for selrand

    %if 2 or more selection were toggled, display error message
    if (best + tourn + sus + rand) >= 2
        error('*** ERROR Please select only one selection ***');
    end
    
    if best == 1
        sel = 1;
    elseif tourn == 1
        sel = 2;
    elseif sus == 1
        sel = 3;
    else
        sel = 4;
    end
end 