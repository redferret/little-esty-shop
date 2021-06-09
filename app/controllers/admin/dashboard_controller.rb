class Admin::DashboardController < ApplicationController
  def index
    @incomplete_invoices = Invoice.incomplete_oldest_first
  end
end
