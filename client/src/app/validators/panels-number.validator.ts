import {AbstractControl, FormGroup, ValidationErrors, ValidatorFn} from "@angular/forms";
export function panelsNumberValidator(): ValidatorFn  {
  return (form: AbstractControl): ValidationErrors | null => {
    const panelsNumber = form.get('panelsNumber')?.value;
    const panelsIds = form.get('panelsIds')?.value;
    if (panelsNumber === undefined || panelsIds === '') return null;

    const currentLength = panelsIds.split(',').filter((id: string) => id.length > 0).length;
    const differentNumber = currentLength !== panelsNumber;
    return differentNumber ? {differentNumber: {value: currentLength}} : null;
  }
}
