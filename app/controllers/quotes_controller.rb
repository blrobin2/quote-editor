# frozen_string_literal: true

class QuotesController < ApplicationController
    before_action :set_quote, only: [ :show, :edit, :update, :destroy ]

    def index
        @quotes = current_company.quotes.ordered
    end

    def show; end

    def new
        @quote = Quote.new
    end

    def create
        @quote = current_company.quotes.build(quote_params)

        if @quote.save!
            success_response
        else
            render :new, status: :unprocessable_entity
        end
    end

    def edit; end

    def update
        if @quote.update(quote_params)
            success_response
        else
            render :edit, status: :unprocessable_entity
        end
    end

    def destroy
        @quote.destroy

        success_response
    end

    private

    def set_quote
        @quote = current_company.quotes.find(params[:id])
    end

    def quote_params
        params.require(:quote).permit(:name)
    end

    def success_response
        respond_to do |format|
            format.html { redirect_to quotes_path, notice: t('.success_notice') }
            format.turbo_stream { flash.now[:notice] = t('.success_notice') }
        end
    end
end
