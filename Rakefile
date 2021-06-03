# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require_relative 'config/application'
require 'csv'    

Rails.application.load_tasks

csv_tasks = [:customers, :merchants, :invoices, :items, :invoice_items, :transactions]

namespace :load_csv do
  task :customers => :environment do
    puts '-- clearing old data on customers'
    Customer.destroy_all
    puts '-- Loading ... '
    CSV.foreach('./db/data/customers.csv', headers: true) do |row|
      Customer.create!(row.to_hash)
    end
    puts '-- Loaded Customers'
  end

  task :invoice_items => :environment do
    puts '-- clearing old data on invoice_items'
    InvoiceItem.destroy_all
    puts '-- Loading ... '
    CSV.foreach('./db/data/invoice_items.csv', headers: true) do |row|
      InvoiceItem.create!(row.to_hash)
    end
    puts '-- Loaded InvoiceItems'
  end

  task :invoices => :environment do
    puts '-- clearing old data on invoices'
    Invoice.destroy_all
    puts '-- Loading ... '
    CSV.foreach('./db/data/invoices.csv', headers: true) do |row|
      Invoice.create!(row.to_hash)
    end
    puts '-- Loaded Invoices'
  end

  task :items => :environment do
    puts '-- clearing old data on items'
    Item.destroy_all
    puts '-- Loading ... '
    CSV.foreach('./db/data/items.csv', headers: true) do |row|
      Item.create!(row.to_hash)
    end
    puts '-- Loaded Items'
  end

  task :merchants => :environment do
    puts '-- clearing old data on merchants'
    Merchant.destroy_all
    puts '-- Loading ... '
    CSV.foreach('./db/data/merchants.csv', headers: true) do |row|
      Merchant.create!(row.to_hash)
    end
    puts '-- Loaded Merchants'
  end

  task :transactions => :environment do
    puts '-- clearing old data on transactions'
    Transaction.destroy_all
    puts '-- Loading ... '
    CSV.foreach('./db/data/transactions.csv', headers: true) do |row|
      Transaction.create!(row.to_hash)
    end
    puts '-- Loaded Transactions'
  end

  task :all => :environment do
    csv_tasks.each do |task|
      Rake::Task["load_csv:#{task.to_s}"].reenable
      Rake::Task["load_csv:#{task.to_s}"].invoke
    end
  end
end
