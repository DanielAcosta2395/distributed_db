import { Injectable } from '@nestjs/common';
import { of } from 'rxjs';
import { delay } from 'rxjs/operators';

@Injectable()
export class AppService {
  ping() {
    return of('pong').pipe(delay(1000));
  }
}
