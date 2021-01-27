class TasksController < ApplicationController
    def index
        @tasks = Task.all
        render 'tasks/index'
    end

    def create
        @task = Task.new(task_params)

        # IF saved in database
        if @task.save
            render 'tasks/create'
        end

    end


    def destroy
        
        # Find task in model base on id
        @task = Task.find_by(id: params[:id])
        
        #If task exist and is destroyed.
        if @task and @task.destroy
            render json: {success: true}
        else 
            render json: {success: false}
        end


    end


    
    def mark_complete
        @task = Task.find_by(id: params[:id])
        
        # Check if task exists and task got updated
        if @task and @task.update(completed: true)
            render 'tasks/update'
        end
        
    end
    
    def mark_active 
        @task = Task.find_by(id: params[:id])
        
        # Check if task exists and task got updated
        if @task and @task.update(completed: false)
            render 'tasks/update'
        end

    end


    # Gets :task specific :content
    def task_params
        params.require(:task).permit(:content)
    end
end
