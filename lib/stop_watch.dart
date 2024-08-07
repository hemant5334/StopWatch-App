import 'dart:async' show Timer;

import 'package:flutter/material.dart';

class StopWatch extends StatefulWidget {
  const StopWatch({super.key});

  @override
  State<StopWatch> createState() => _StopWatchState();
}

class _StopWatchState extends State<StopWatch> {
  String _display = 'Stop Watch';
  final _coreWatch = Stopwatch();
  bool _isRunning = false;
  bool _isPaused = true;

  void start() {
    Timer(const Duration(milliseconds: 1), running);
  }

  void running() {
    if (_coreWatch.isRunning) {
      start();
    }
    if (mounted) {
      setState(() {
        _display =
            '${_coreWatch.elapsed.inHours.toString().padLeft(1, '0')}:${(_coreWatch.elapsed.inMinutes % 60).toString().padLeft(2, '0')}:${(_coreWatch.elapsed.inSeconds % 60).toString().padLeft(2, '0')}:${_coreWatch.elapsed.inMilliseconds % 1000}';
      });
    }
  }

  void _startStopWatch() {
    if (mounted) {
      setState(() {
        _isRunning = true;
        _isPaused = false;
      });
    }
    _coreWatch.start();
    start();
  }

  void _stopStopWatch() {
    if (mounted) {
      setState(() {
        _isRunning = true;
        _isPaused = true;
      });
    }
    _coreWatch.stop();
  }

  void _resetStopWatch() {
    if (mounted) {
      setState(() {
        _isRunning = false;
        _isPaused = true;
      });
    }
    _coreWatch.reset();
    _display = 'Stop Watch';
  }

  @override
  Widget build(BuildContext context) => Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const SizedBox(),
          Text(
            _display,
            style: const TextStyle(fontSize: 60.0, fontWeight: FontWeight.bold),
          ),
          ElevatedButton(
            style: ButtonStyle(
              shape: WidgetStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50.0),
                ),
              ),
              overlayColor: WidgetStateProperty.all(
                Colors.black.withOpacity(0.2),
              ),
              elevation: WidgetStateProperty.all(8),
              foregroundColor: WidgetStateProperty.all(Colors.black),
              backgroundColor: WidgetStateProperty.all(Colors.white),
              padding: WidgetStateProperty.all(
                const EdgeInsets.symmetric(vertical: 6, horizontal: 15),
              ),
            ),
            onPressed: _isRunning
                ? _isPaused
                    ? _resetStopWatch
                    : _stopStopWatch
                : _startStopWatch,
            child: Text(
              _isRunning
                  ? _isPaused
                      ? 'Reset'
                      : 'Stop'
                  : 'Start',
              style:
                  const TextStyle(fontSize: 34.0, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      );
}
