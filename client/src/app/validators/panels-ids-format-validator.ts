import {AbstractControl, ValidationErrors, ValidatorFn} from "@angular/forms";

export function panelsIdsFormatValidator(): ValidatorFn {
  return (control: AbstractControl): ValidationErrors | null => {
    if (control.value === undefined) return null;

    const currentIds = control.value.split(',');
    const invalidFormatFound: string = currentIds.find((id: string) => {
      const strippedId = id.replace(/^\s+|\s+$/g, '');
      return ! /^[0-9]{6}$/.test(strippedId);
    });
    return invalidFormatFound ? { invalidIdsFormat: { value: invalidFormatFound } } : null;
  }
}
