module Admin


    class SpeciesController < ApplicationController
        
        def index 
            @species = Species.all
        end

        def new
            @species = Species.new
        end

        def create
            @species = Species.new(species_params)
            if @species.save
                redirect_to({action: :index}, success: 'Species was successfully created.')
            else
                render :new
            end
        end

        def edit

        end

        def update
            if @species.update(species_params)
                redirect_to({action: :index}, success: 'Species was successfully updated.')
            else
                render :new
            end
        end

        def destroy
            @species.destroy
            redirect_to({action: :index}, success: 'Species was successfully deleted.')
        end

        private

        def species_params
            params.require(:species).permit(:name, :slug)
        end

        def set_species
            @species = Species.find(params[:id])
        end
        
    end
end

