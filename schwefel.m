%uloha1
%isid92654
%Schwefel

space_down = ones(1,10) * -500; %lowest value
space_up = ones(1,10) * 500; %highest value
space = [space_down; space_up]; %space used for generating population
pop_size = 100; %population size(how many individuals)
num_of_best_ones = [15, 10, 5]; %how many individuals go to next generation (3x best, 2x second best, ...)
num_of_cycles = 500;

%toggles
%selection
selbest_toggle = 1;
seltourn_toggle = 0;
selsus_toggle = 0;
selrand_toggle = 0;
selection = get_selection(selbest_toggle, seltourn_toggle, selsus_toggle, selrand_toggle);
%mutation
mutx_toggle = 1;
muta_toggle = 0;
mutn_toggle = 0;
mutm_toggle = 0;
%crossing
crossov_toggle = 1;
crossov_intmedx = 0;
crossov_around = 0;

population = genrpop(pop_size,space); %generate population

fit_of_population = get_fit_of_population(pop_size, population);
best_individuals = zeros(1,pop_size);

for i = 1:num_of_cycles
    fit_of_population = get_fit_of_population(pop_size, population); %fitness
    best_individuals(i) = min(fit_of_population); %take best one for graph
    new_population = selbest(population, fit_of_population, num_of_best_ones);
    
end

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

function fit = get_fit_of_population(pop_size, population)
%returns matrix of function values
    fit = zeros(1,pop_size);
    
    for individ = 1:pop_size
        fit(individ) = testfn3(population(individ));
    end
end