class AssetsController < ApplicationController
  def new
  end

  def create
    portfolio = PortfolioRepository.load(params[:portfolio_id])
    portfolio = portfolio.add(params[:symbol], params[:shares].to_i, Money.parse(params[:price]))
    saved_id = PortfolioRepository.save(portfolio)
    redirect_to portfolio_url(saved_id)
  end
end
