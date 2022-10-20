import 'package:flutter/material.dart';
import 'package:logging/logging.dart';

class Log {
   static const String name = 'logger';
   static late Logger _instance;
   static void init(){
     _instance = Logger(name);
     _instance.onRecord.listen((event) {
       debugPrint('${event.level.name}: ${event.time}: ${event.message}');
     });
   }
   static set level(Level level){
     Logger.root.level = level;
   }

   static Level get level => Logger.root.level;

   static void info(String message, [Object? error, StackTrace? stackTrace]){
     _instance.info(message, error, stackTrace);
   }

   static void warning(String message, [Object? error, StackTrace? stackTrace]){
     _instance.warning(message, error, stackTrace);
   }

   static void config(String message, [Object? error, StackTrace? stackTrace]){
     _instance.config(message, error, stackTrace);
   }

   static void fine(String message, [Object? error, StackTrace? stackTrace]){
     _instance.fine(message, error, stackTrace);
   }

   static void finer(String message, [Object? error, StackTrace? stackTrace]){
     _instance.finer(message, error, stackTrace);
   }

   static void finest(String message, [Object? error, StackTrace? stackTrace]){
     _instance.finest(message, error, stackTrace);
   }

   static void severe(String message, [Object? error, StackTrace? stackTrace]){
     _instance.severe(message, error, stackTrace);
   }

   static void shout(String message, [Object? error, StackTrace? stackTrace]){
     _instance.shout(message, error, stackTrace);
   }

}