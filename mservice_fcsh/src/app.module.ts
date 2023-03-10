import { Module } from '@nestjs/common';
import { AppController } from './app.controller';
import { AppService } from './app.service';
import { TypeOrmModule } from '@nestjs/typeorm';

@Module({
  imports: [
    TypeOrmModule.forRoot({
      type: 'postgres',
      host: 'database',
      port: 5432,
      username: 'uaslp_fcsh',
      password: 'admin',
      database: 'uaslp_fcsh',
      entities: [],
    }),
  ],
  controllers: [AppController],
  providers: [AppService],
})
export class AppModule {}