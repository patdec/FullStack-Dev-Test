export interface Country {
  id: number,
  name: string,
  iso: string
}

export interface Address {
  id: number,
  street: string,
  zipcode: string,
  city: string
  country: Country
}

export interface  Customer {
  id: number,
  name: string,
  email: string,
  phone: string
}

export interface  Installer {
  id: number,
  name: string,
  siren: string
}

export interface  Installation {
  id: number,
  installer: Installer,
  customer: Customer,
  address: Address,
  panels_type: 'photovoltaic'| 'hybrid',
  panels_number: number,
  panels_ids: string
}
