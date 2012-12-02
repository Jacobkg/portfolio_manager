class PortfoliosController < ApplicationController
  def new
  end

  def create
    portfolio = Portfolio.new(params[:name])
    id = PortfolioRepository.save(portfolio)
    redirect_to portfolio_url(id)
  end

  def show
    @portfolio = PortfolioRepository.load(params[:id])
  end

  def price_update
    portfolio = PortfolioRepository.load(params[:id])
    updated_portfolio = portfolio.update_prices
    PortfolioRepository.save(updated_portfolio)
    redirect_to portfolio_url(params[:id])
  end

end
