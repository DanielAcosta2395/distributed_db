import { Module } from '@nestjs/common';
import { AppController } from './app.controller';
import { TypeOrmModule } from '@nestjs/typeorm';
import { ClientsModule, Transport } from '@nestjs/microservices';
import { AppService } from './app.service';

@Module({
  imports: [
    TypeOrmModule.forRoot({
      type: 'postgres',
      host: 'database',
      port: 5432,
      username: 'uaslp_localization',
      password: 'admin',
      database: 'uaslp_localization',
      entities: [],
    }),
    ClientsModule.register([
      {
        name: 'mservice_fi',
        transport: Transport.TCP,
        options: {
          host: 'mservice_fi',
          port: 8888,
        },
      },
    ]),
  ],
  controllers: [AppController],
  providers: [AppService],
})
export class AppModule {}
