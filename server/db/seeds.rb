# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

countries = [
  { name: 'France', iso: 'FR' },
  { name: 'Allemagne', iso: 'DE' },
  { name: 'Royaume-Uni', iso: 'UK' },
  { name: 'Italie', iso: 'I' },
  { name: 'Espagne', iso: 'E' },
]
countries.each { |country| Country.create(country) }

installers = [
  { name: 'SA Sun Star', siren: '111222333' },
  { name: 'SARL Panel Sud', siren: '111222444' },
  { name: 'EURL Sun First', siren: '111222555' }
]

installers.each { |installer| Installer.create(installer) }