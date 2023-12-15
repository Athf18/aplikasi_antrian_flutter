// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class CsPage extends StatefulWidget {
  const CsPage({super.key});
  @override
  State<CsPage> createState() => _CsPage();
}

class _CsPage extends State<CsPage> {
  late AudioPlayer player;
  bool isButtonEnabled = true;
  final _audioCache = AudioPlayer();

  Future<void> playAwal() async {
    await _audioCache.play(AssetSource('tingtung.wav'));
    await _audioCache.onSeekComplete.first;
    await _audioCache.play(AssetSource('rekaman/nomor-urut.wav'));
  }

  Future<void> playQueueNumber(int number) async {
    if (number == 10) {
      await _audioCache.play(AssetSource('rekaman/sepuluh.wav'));
    } else if (number == 11) {
      await _audioCache.play(AssetSource('rekaman/sebelas.wav'));
    } else if (number == 100) {
      await _audioCache.play(AssetSource('rekaman/seratus.wav'));
    } else if (number < 10) {
      await _audioCache.play(AssetSource('rekaman/$number.wav'));
    } else if (number < 20) {
      int posisi = number % 10;
      await _audioCache.play(AssetSource('rekaman/$posisi.wav'));
      await _audioCache.onSeekComplete.first;
      await _audioCache.play(AssetSource('rekaman/belas.wav'));
    } else if (number < 100) {
      int posisidepan = number ~/ 10;
      int posisibelakang = number % 10;
      await _audioCache.play(AssetSource('rekaman/$posisidepan.wav'));
      await _audioCache.onSeekComplete.first; // Menunggu pemutaran selesai
      await _audioCache.play(AssetSource('rekaman/puluh.wav'));
      await _audioCache.onSeekComplete.first;
      if (posisibelakang != 0) {
        await _audioCache.play(AssetSource('rekaman/$posisibelakang.wav'));
      }
    } else if (number == 100) {
      await _audioCache.play(AssetSource('rekaman/seratus.wav'));
    } else if (number < 200) {
      await _audioCache.play(AssetSource('rekaman/seratus.wav'));
      await _audioCache.onPlayerComplete.first;
      int numberratus = number - 100;
      if (numberratus != 0) {
        playQueueNumber(numberratus);
      }
    } else if (number < 999) {
      int numberdepan = number ~/ 100;
      int numberbelakang = number % 100;
      await playQueueNumber(numberdepan);
      await _audioCache.onPlayerComplete.first;
      await _audioCache.play(AssetSource('rekaman/ratus.wav'));
      if (numberbelakang != 0) {
        await _audioCache.onPlayerComplete.first;  
        await playQueueNumber(numberbelakang);
      }

      //await _audioCache.play(AssetSource('rekaman/$numberdepan.wav'));
    }
  }

  Future<void> playFrontSound() async {
    await _audioCache.play(AssetSource('tingtung.wav'));
    await _audioCache.onPlayerComplete.first;
    await _audioCache.play(AssetSource('rekaman/nomor-urut.wav'));

  }

   Future<void> playEndSound() async {
    await _audioCache.play(AssetSource('rekaman/loket.wav'));
    await _audioCache.onPlayerComplete.first;
    playQueueNumber(posisiteler);

  }

  void disableButton() {
    setState(() {
      isButtonEnabled = false;
    });
  }


  void enableButton() {
    setState(() {
      isButtonEnabled = true;
    });
  }

  int queueNumber = 1;
  int posisiteler =1;

  void AddPosisiTeler(){
    setState(() {
      posisiteler++;
    });
  }

  void MinPosisiAntri () {
    setState(() {
      if(queueNumber<=1){
        queueNumber=1;
      } else {
        queueNumber--;
      }
    });
  }

  void MinPosisiTeler(){
    setState(() {
      if(posisiteler <= 1){
        posisiteler=1;
      } else {
        posisiteler--;
      }
      
    });
  }

  @override
  void initState() {
    super.initState();
    player = AudioPlayer();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Antrian Customer Service')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Pilih posisi Customer Service'),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(Icons.remove),
                  onPressed: () {
                    MinPosisiTeler();
                  },
                ),
                Text('$posisiteler', style: TextStyle(fontSize: 60, fontWeight: FontWeight.w700),),
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    AddPosisiTeler();
                  },
                ),
              ],
            ),
            Text(
              'Posisi Nomor Antrian Saat Ini :',
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
            ),
            SizedBox(
              height: 50,
            ),
            Container(
              alignment: Alignment.center,
              width: 250,
              height: 200,
              decoration: BoxDecoration(
                color: Colors.green[800],
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              child: Text(
                '${queueNumber}',
                style: TextStyle(
                    fontSize: 100,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
            const SizedBox(
              height: 100,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: isButtonEnabled
                      ? () async {
                          MinPosisiAntri();
                          disableButton();
                          setState(() {});
                          await playFrontSound();
                          await _audioCache.onPlayerComplete.first;
                          await playQueueNumber(queueNumber);
                          await _audioCache.onPlayerComplete.first;
                          await playEndSound();
                          enableButton();
                          setState(() {});
                        }
                      : null,
                  style: ButtonStyle(
                      fixedSize: MaterialStateProperty.all(Size(100, 80)),
                      backgroundColor:
                          const MaterialStatePropertyAll(Colors.red)),
                  child: const Text(
                    'PREV',
                    softWrap: true,
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                ElevatedButton(
                  onPressed: isButtonEnabled
                      ? () async {
                          disableButton();
                          setState(() {});
                          await playFrontSound();
                          await _audioCache.onPlayerComplete.first;
                          await playQueueNumber(queueNumber);
                          await _audioCache.onPlayerComplete.first;
                          await playEndSound();
                          enableButton();
                          setState(() {});
                        }
                      : null,
                  style: ButtonStyle(
                      fixedSize: MaterialStateProperty.all(Size(100, 80)),
                      backgroundColor:
                          MaterialStatePropertyAll(Colors.blue[600])),
                  child: const Text('CURRENT'),
                ),
                const SizedBox(
                  width: 20,
                ),
                ElevatedButton(
                    onPressed: isButtonEnabled
                        ? () async {
                            queueNumber++;
                            disableButton();
                            setState(() {});
                            await playFrontSound();
                            await _audioCache.onPlayerComplete.first;
                            await playQueueNumber(queueNumber);
                            await _audioCache.onPlayerComplete.first;
                            await playEndSound();
                            enableButton();
                            setState(() {});
                          }
                        : null,
                    style: ButtonStyle(
                      fixedSize: MaterialStateProperty.all(Size(100, 80)),
                      backgroundColor:
                          MaterialStateProperty.all(Colors.orange[800]),
                    ),
                    child: const Text(
                      'NEXT',
                      softWrap: true,
                    )),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }
}
