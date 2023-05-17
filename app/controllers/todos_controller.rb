# frozen_string_literal: true

class TodosController < ApplicationController
  def index
    todos = Todo.all
    render json: todos
  end

  def show
    todo = Todo.find(params[:id])
    render json: todo
  end

  def create
    todo = Todo.new(todo_params)

    if todo.save
      render json: todo, status: :created
    else
      render json: todo.errors, status: :unprocessable_entity
    end
  end

  def destroy
    todo = Todo.find(params[:id])

    if todo.destroy
      render json: { status: 'SUCCESS', message: 'Deleted the todo', data: todo }, status: :ok
    else
      render json: { status: 'ERROR', message: 'Todo not deleted', data: todo.errors },
             status: :unprocessable_entity
    end
  end

  private

  def todo_params
    params.require(:todo).permit(:title, :contents)
  end
end
