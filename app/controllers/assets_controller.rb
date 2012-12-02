class AssetsController < ApplicationController
  def new
  end

  def create
    portfolio = PortfolioRepository.load(params[:portfolio_id])
    if params[:asset_class] == "bond"
      updated_portfolio = portfolio.add_bond(params[:symbol], params[:shares].to_f, Money.parse(params[:price]))
    elsif params[:asset_class] == "stock"
      updated_portfolio = portfolio.add_bond(params[:symbol], params[:shares].to_f, Money.parse(params[:price]))
    else
      raise "Unknown Asset Class"
    end
    saved_id = PortfolioRepository.save(updated_portfolio)
    redirect_to portfolio_url(saved_id)
  end

  def edit
    portfolio = PortfolioRepository.load(params[:portfolio_id])
    @entry = portfolio.asset(params[:id])
  end

  def update
    portfolio = PortfolioRepository.load(params[:portfolio_id])
    @entry = portfolio.asset(params[:id])
    updated_portfolio = portfolio.update(params[:symbol], params[:shares].to_f, Money.parse(params[:price]))
    saved_id = PortfolioRepository.save(updated_portfolio)
    redirect_to portfolio_url(saved_id)
  end
end
