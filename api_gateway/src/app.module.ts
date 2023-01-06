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
        name: 'MSERVICE_FI',
        transport: Transport.TCP,
        options: {
          host: 'MSERVICE_FI',
          port: 8888,
        },
      },
    ]),
  ],
  controllers: [AppController],
  providers: [AppService],
})
export class AppModule {}
