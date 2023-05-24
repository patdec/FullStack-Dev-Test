import { Component, OnInit } from '@angular/core';
import {Observable} from "rxjs";
import {Country, Installer} from "../../../interfaces/installation.interface";
import {HttpClient, HttpErrorResponse} from "@angular/common/http";
import {map} from "rxjs/operators";
import {FormControl, FormGroup, Validators} from "@angular/forms";
import {panelsNumberValidator} from "../../../validators/panels-number.validator";
import {panelsIdsFormatValidator} from "../../../validators/panels-ids-format-validator";

interface CountriesResponse {
  countries: Country[]
}

interface InstallersResponse {
  installers: Installer[]
}

interface InstallationPayload {
  installation: {
    installer_id: number,
    panels_type: 'hybrid' | 'photovoltaic',
    panels_number: number,
    panels_ids: string[],
    date: string,
    customer_attributes: {
      name: string,
      email: string,
      phone: string
    },
    address_attributes: {
      street: string,
      zipcode: string,
      city: string,
      country_id: number,
    }
  }
}

@Component({
  selector: 'app-new-installation',
  templateUrl: './new-installation.component.html',
  styleUrls: ['./new-installation.component.scss']
})
export class NewInstallationComponent implements OnInit {
  HOST = 'http://127.0.0.1:3000';

  installers$: Observable<Installer []>;
  countries$: Observable<Country []>;
  possiblePanelsType: string[] = ['hybrid', 'photovoltaic'];
  success = false;
  message = '';

  form = new FormGroup({
      installer: new FormControl({}, Validators.required),
      customerName: new FormControl('', [Validators.required, Validators.maxLength(255)]),
      customerEmail: new FormControl('', [Validators.required, Validators.pattern('[a-zA-Z0-9-]+@[a-zA-Z0-9-]+\.[a-zA-Z]{2,}'), Validators.maxLength(255)]),
      customerPhone: new FormControl('', [Validators.required, Validators.pattern('[0-9-\/\+\(\) -]{10,}')]),
      addressStreet: new FormControl('', [Validators.required, Validators.maxLength(255)]),
      addressZipcode: new FormControl('', [Validators.required, Validators.maxLength(20)]),
      addressCity: new FormControl('', [Validators.required, Validators.maxLength(100)]),
      addressCountry: new FormControl({}, Validators.required),
      date: new FormControl('', Validators.required),
      panelsType: new FormControl('', Validators.required),
      panelsNumber: new FormControl('', [Validators.required, Validators.max(50), Validators.min(1)]),
      panelsIds: new FormControl('', [Validators.required, panelsIdsFormatValidator()])
    }, panelsNumberValidator());


  constructor(private httpClient: HttpClient) {
    this.countries$ = this.httpClient.get<CountriesResponse>(`${this.HOST}/countries`)
                                     .pipe(map((c) => c.countries));
    this.installers$ = this.httpClient.get<InstallersResponse>(`${this.HOST}/installers`)
                                      .pipe(map((i) => i.installers));
  }

  ngOnInit(): void {

  }

  get customerName() { return this.form.get('customerName'); }
  get customerEmail() { return this.form.get('customerEmail'); }
  get customerPhone() { return this.form.get('customerPhone'); }
  get addressStreet() { return this.form.get('addressStreet'); }
  get addressZipcode() { return this.form.get('addressZipcode'); }
  get addressCity() { return this.form.get('addressCity'); }
  get addressCountry() { return this.form.get('addressCountry'); }
  get panelsType() { return this.form.get('panelsType'); }
  get date() { return this.form.get('date'); }
  get panelsNumber() { return this.form.get('panelsNumber'); }
  get panelsIds() { return this.form.get('panelsIds'); }
  get installer() { return this.form.get('installer'); }

  onSubmit() {
    if (!this.form.valid) return;

    this.httpClient.post<string>(`${this.HOST}/installations`, this.buildParams())
                   .subscribe((response) => {
                     this.success = true;
                     this.message = "L'installation a bien été créée";
                   },
                     (error: HttpErrorResponse) => {
                     this.success = false;
                       this.message = JSON.stringify(error.error.error);
                     });
  }

  private buildParams(): InstallationPayload {
    return {
      installation: {
        installer_id: this.form.get('installer')?.value,
        panels_type: this.form.get('panelsType')?.value,
        panels_number: this.form.get('panelsNumber')?.value,
        panels_ids: this.buildIdsArray(),
        date: this.form.get('date')?.value,
        customer_attributes: {
          name: this.form.get('customerName')?.value,
          email: this.form.get('customerEmail')?.value,
          phone: this.form.get('customerPhone')?.value
        },
        address_attributes: {
          street: this.form.get('addressStreet')?.value,
          zipcode: this.form.get('addressZipcode')?.value,
          city: this.form.get('addressCity')?.value,
          country_id: this.form.get('addressCountry')?.value,
        }
      }
    }
  }

  private buildIdsArray(): string[] {
    return this.form.get('panelsIds')?.value.split(',')
      .filter((id: string) => id.length > 0)
      .map((id: string) => id.replace(/^\s+|\s+$/g, ''));
  }
}
