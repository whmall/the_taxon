class NodesController < ::Admin::BaseController
  before_action :set_node, only: [:show, :edit, :update, :destroy]

  def index
    @nodes = Node.page(params[:page])
  end

  def show
  end

  def new
    @node = Node.new(parent_id: params[:parent_id])
    @options = Node.select(:id, :name).all
  end

  def edit
    @options = Node.select(:id, :name)
  end

  def create
    @node = Node.new(node_params)

    if @node.save
      redirect_to nodes_url, notice: 'Node was successfully created.'
    else
      render :new
    end
  end

  def update
    if @node.update(node_params)
      redirect_to nodes_url, notice: 'Node was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @node.destroy
    redirect_to nodes_url, notice: 'Node was successfully destroyed.'
  end

  private
  def set_node
    @node = Node.find(params[:id])
  end

  def node_params
    params.fetch(:node, {}).permit(:name, :description, :parent_id)
  end

end
