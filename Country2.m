classdef Country2 < handle
    properties (Access = public)
        CountryIndex double
        CountryName string
        StatesCasesCum cell
        StatesDeathsCum cell
        StatesCasesDaily cell
        StatesDeathsDaily cell
        States cell
    end
    methods
        function obj = Country2(covid_data, NameOfCountry, ...
                               FirstIndexOfCountry, LastIndexOfCountry)
            obj.CountryIndex = FirstIndexOfCountry;
            obj.CountryName = NameOfCountry;
            obj.StatesCasesCum = covid_data(FirstIndexOfCountry:LastIndexOfCountry,2);
            obj.StatesCasesDaily = obj.StatesCasesCum;
            obj.StatesDeathsCum = covid_data(FirstIndexOfCountry:LastIndexOfCountry,2);
            obj.StatesDeathsDaily = obj.StatesDeathsCum;
            obj.States = covid_data(FirstIndexOfCountry:LastIndexOfCountry,2);
            CasesCum = ones(1, size(covid_data,2)-2); DeathsCum = ones(1, size(covid_data,2)-2);
            CasesDaily = CasesCum; 
            DeathsDaily = DeathsCum;
            
            for i = 1:size(obj.States,1)
                obj.States(i, 2:size(covid_data,2)-1) = covid_data(FirstIndexOfCountry+i-1, 3:end);
                CasesDaily(1,1) = obj.States{i,2}(1);
                DeathsDaily(1,1) = obj.States{i,2}(2);
                for j = 2:size(covid_data,2)-2
                    CasesCum(1, j-1) = obj.States{i, j}(1);
                    if (obj.States{i, j+1}(1)-obj.States{i, j}(1)) < 0
                        CasesDaily(1, j) = 0;
                    else
                        CasesDaily(1, j) = obj.States{i, j+1}(1)-obj.States{i, j}(1);
                    end
                    
                    DeathsCum(1, j-1) = obj.States{i, j}(2); 
                    if (obj.States{i, j+1}(2)-obj.States{i, j}(2)) < 0
                        DeathsDaily(1, j) = 0;
                    else
                        DeathsDaily(1, j) = obj.States{i, j+1}(2)-obj.States{i, j}(2);
                    end
                    
                end
                CasesCum(1, end) = obj.States{i, end}(1);
                DeathsCum(1, end) = obj.States{i, end}(2);
                obj.StatesCasesCum(i, 2) = {CasesCum};
                obj.StatesCasesDaily(i, 2) = {CasesDaily};
                obj.StatesDeathsCum(i, 2) = {DeathsCum};
                obj.StatesDeathsDaily(i, 2) = {DeathsDaily};
                
            end
            
        end
    end
end