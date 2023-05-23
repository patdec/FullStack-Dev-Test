import { ComponentFixture, TestBed } from '@angular/core/testing';

import { NewInstallationComponent } from './new-installation.component';

describe('NewInstallationComponent', () => {
  let component: NewInstallationComponent;
  let fixture: ComponentFixture<NewInstallationComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ NewInstallationComponent ]
    })
    .compileComponents();
  });

  beforeEach(() => {
    fixture = TestBed.createComponent(NewInstallationComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
