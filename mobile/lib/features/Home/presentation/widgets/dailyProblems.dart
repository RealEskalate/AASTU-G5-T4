import 'package:flutter/material.dart';

class LeetcodeCard extends StatelessWidget {
  const LeetcodeCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        height: 400,
        decoration: BoxDecoration(
          color: const Color(0xFFD4EBD9), // Light mint green background
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Text(
                        'Daily problem',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF2D3B36),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: const Color(0xFF798780),
                            width: 1.5,
                          ),
                        ),
                        child: const Icon(
                          Icons.access_time_rounded,
                          size: 16,
                          color: Color(0xFF798780),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.arrow_upward,
                        size: 20,
                        color: Color(0xFF798780),
                      ),
                      const SizedBox(width: 4),
                      const Text(
                        '0',
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(0xFF798780),
                        ),
                      ),
                      const SizedBox(width: 4),
                      const Icon(
                        Icons.arrow_downward,
                        size: 20,
                        color: Color(0xFF798780),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 4),
              // Subtitle
              const Text(
                'Refreshes every 24 hours and\nneeds to be solved today!',
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0xFF798780),
                ),
              ),
              const SizedBox(height: 20),
              // Problem title
              const Text(
                'Find Kth Bit In Nth Binary String',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF2D3B36),
                ),
              ),
              const SizedBox(height: 12),
              // Tags
              Row(
                children: [
                  const Text(
                    'Leetcode',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF2D3B36),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    width: 4,
                    height: 4,
                    decoration: BoxDecoration(
                      color: const Color(0xFF2D3B36),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    'Medium',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF2D3B36),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    width: 4,
                    height: 4,
                    decoration: BoxDecoration(
                      color: const Color(0xFF2D3B36),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    'Recursion',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF2D3B36),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              // Action buttons
              Container(
                height: 45,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.play_arrow_outlined,
                      size: 20,
                      color: Color(0xFF2D3B36),
                    ),
                    const SizedBox(width: 8),
                    const Text(
                      'Solve It Now',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF2D3B36),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              // New solution button
              Container(
                height: 45,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: const Color(0xFF2D3B36).withOpacity(0.2),
                    width: 1,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.add,
                      size: 20,
                      color: Color(0xFF2D3B36),
                    ),
                    const SizedBox(width: 8),
                    const Text(
                      'New Solution',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF2D3B36),
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              // Stats at the bottom
              Center(
                child: Column(
                  children: [
                    const Text(
                      '374',
                      style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2D3B36),
                      ),
                    ),
                    const Text(
                      'Solved it',
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(0xFF798780),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
