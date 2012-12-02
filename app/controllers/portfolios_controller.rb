class PortfoliosController < ApplicationController
  def new
  end

  def create
    portfolio = Portfolio.new(params[:name])
    id = PortfolioRepository.save(portfolio)
    redirect_to "/portfolios/#{id}"
  end

  def show
    @portfolio = PortfolioRepository.load(params[:id])
  end
end
