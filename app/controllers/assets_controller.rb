class AssetsController < ApplicationController
  def new
  end

  def create
    portfolio = PortfolioRepository.load(params[:portfolio_id])
    updated_portfolio = portfolio.add(params[:symbol], params[:shares].to_i, Money.parse(params[:price]))
    saved_id = PortfolioRepository.save(updated_portfolio)
    redirect_to portfolio_url(saved_id)
  end
end
