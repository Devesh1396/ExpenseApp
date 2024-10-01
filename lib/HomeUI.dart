import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'app_colors.dart';
import 'package:fl_chart/fl_chart.dart'; // Import the fl_chart package


class HomeUI extends StatefulWidget {
  @override
  _HomeUIState createState() => _HomeUIState();
}

class _HomeUIState extends State<HomeUI> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondaryColor.withOpacity(0.2),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        toolbarHeight: 80, // Custom height for the app bar
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 24,
                  backgroundImage: AssetImage('assets/images/user_profile.png'),
                ),
                SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Hello,',
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                    Text(
                      'Charles David',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
            ),
            IconButton(
              icon: Icon(Icons.notifications_none, color: Colors.black, size: 28),
              onPressed: () {
                // Handle notification click
              },
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Total Balance
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total Balance',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                GestureDetector(
                  onTap: () {
                    // Handle 'View all' click
                  },
                  child: Text(
                    'View all',
                    style: TextStyle(fontSize: 14, color: AppColors.primaryColor),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Text(
              '\u20B9 223,876', // This will be dynamic
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: AppColors.primaryColor),
            ),
            SizedBox(height: 20),

            // Income and Expense Cards (Placeholders for now)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildIncomeExpenseCard('Income', '\u20B9 273,876', Colors.green, 'assets/images/increase.svg'),
                _buildIncomeExpenseCard('Expense', '\u20B9 50,000', Colors.red, 'assets/images/decrease.svg'),
              ],
            ),
            SizedBox(height: 20),

            // Placeholder for Expense Chart
            _buildChartSection(),

            SizedBox(height: 20),

            // My Goals Section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'My Goals',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                GestureDetector(
                  onTap: () {
                    // Handle 'View all' click
                  },
                  child: Text(
                    'View all',
                    style: TextStyle(fontSize: 14, color: AppColors.primaryColor),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            _buildGoalsList(),

          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primaryColor,
        child: Icon(Icons.add, color: Colors.white),
        onPressed: (){
        },
      ),
    );
  }


  Widget _buildIncomeExpenseCard(String title, String amount, Color color, String svgPath) {
    return Container(
      width: MediaQuery.of(context).size.width / 2 - 24, // Adjust width
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Row(
        children: [
          // Icon Container
          Expanded(
            flex: 1, // This will allow the icon container to take 1 part of the available space
            child: Container(
              padding: EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1), // Light background color for the SVG container
                shape: BoxShape.circle,
              ),
              child: SvgPicture.asset(
                svgPath,
                width: 60,
                height: 60,
                color: color, // Color the SVG with the appropriate color
              ),
            ),
          ),
          SizedBox(width: 10), // Space between icon and text

          // Column for Title and Amount
          Expanded(
            flex: 2, // This will allow the text container to take 2 parts of the available space
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(fontSize: 16, color: color, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 5),
                Text(
                  amount,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }



  Widget _buildGoalsList() {
    return Column(
      children: [
        _buildGoalItem(
          'Play Station',
          0.8,
          '₹2,200 saved',
          '₹1,000 left',
          Icons.videogame_asset, // Icon for this goal
        ),
        SizedBox(height: 16), // Spacing between the cards
        _buildGoalItem(
          'Vacation Trip',
          0.4,
          '₹10,000 saved',
          '₹15,000 left',
          Icons.flight, // Icon for this goal
        ),
      ],
    );
  }

// Method to build each goal item using ListTile with static data
  Widget _buildGoalItem(String title, double progress, String saved, String left, IconData icon) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8,
            spreadRadius: 2,
          ),
        ],
      ),
      child: ListTile(
        contentPadding: EdgeInsets.all(16),
        leading: Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppColors.secondaryColor.withOpacity(0.3), // Light background color for the icon
            shape: BoxShape.circle, // Circular shape for the icon container
          ),
          child: Icon(
            icon,
            color: AppColors.primaryColor,
            size: 24,
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),

            // Progress Bar
            LinearProgressIndicator(
              value: progress, // Set the progress (0.0 to 1.0)
              backgroundColor: Colors.grey[300], // Background color of the bar
              color: AppColors.primaryColor, // Progress color
              minHeight: 8, // Thickness of the progress bar
            ),
            SizedBox(height: 8),

            // Row for the saved and left amounts
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  saved,
                  style: TextStyle(fontSize: 14, color: AppColors.primaryColor),
                ),
                Text(
                  left,
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Dropdown Selector wrapped in a Container
  Widget _buildSortingDropdown() {
    String dropdownValue = 'Weekly';

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            spreadRadius: 1,
          ),
        ],
      ),
      child: DropdownButton<String>(
        value: dropdownValue,
        onChanged: (String? newValue) {
          setState(() {
            dropdownValue = newValue!;
          });
        },
        underline: SizedBox(), // Remove the default underline
        items: <String>['Weekly', 'Monthly', 'Yearly']
            .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildLineChart() {
    return LineChart(
      LineChartData(
        // Remove border for a clean look
        borderData: FlBorderData(
          show: false,
        ),
        gridData: FlGridData(
          show: true, // Show grid lines
          drawHorizontalLine: true,
          drawVerticalLine: false,
          horizontalInterval: 4000, // Grid lines every 4k interval
          getDrawingHorizontalLine: (value) {
            return FlLine(
              color: Colors.grey[300]!,
              strokeWidth: 1,
            );
          },
        ),
        titlesData: FlTitlesData(
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 32,
              interval: 1, // Set interval to 1 to show unique labels
              getTitlesWidget: (value, meta) {
                // Map the X values to days of the week
                const daysOfWeek = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
                if (value.toInt() >= 0 && value.toInt() < daysOfWeek.length) {
                  return Text(daysOfWeek[value.toInt()]);
                }
                return Text(''); // Empty text for values out of bounds
              },
            ),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 40,
              interval: 4000, // Set interval to 4k for Y-axis labels
              getTitlesWidget: (value, meta) {
                if (value >= 0 && value <= 20000) {
                  return Text('${(value / 1000).toStringAsFixed(0)}k');
                }
                return Container(); // Hide labels out of bounds
              },
            ),
          ),
          rightTitles: AxisTitles(
            sideTitles: SideTitles(showTitles: false), // Hide right titles
          ),
          topTitles: AxisTitles(
            sideTitles: SideTitles(showTitles: false), // Hide top titles
          ),
        ),
        lineTouchData: LineTouchData(
          handleBuiltInTouches: true,
          touchTooltipData: LineTouchTooltipData(
            //tooltipBgColor: Colors.transparent, // No background for the tooltip
            getTooltipItems: (touchedSpots) {
              return touchedSpots.map((spot) {
                // Show tooltips only for the current week's line (index 0)
                if (spot.barIndex == 0) {
                  return LineTooltipItem(
                    '₹${spot.y.toStringAsFixed(0)}',
                    TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  );
                }
                return null; // No tooltip for the previous week line
              }).toList();
            },
          ),
          touchCallback: (FlTouchEvent event, LineTouchResponse? touchResponse) {
            // Filter out touches to make previous week's line non-interactive
            if (touchResponse != null && touchResponse.lineBarSpots != null) {
              final touchedSpot = touchResponse.lineBarSpots![0];
              if (touchedSpot.barIndex == 1) {
                return; // Ignore touches for the previous week's line
              }
            }
            setState(() {}); // Redraw to show/hide dots on tap
          },
          enabled: true,
        ),
        lineBarsData: [
          // Current week's expenses line
          LineChartBarData(
            spots: [
              FlSpot(0, 3000),
              FlSpot(1, 5000),
              FlSpot(2, 7000),
              FlSpot(3, 9000),
              FlSpot(4, 8000),
              FlSpot(5, 12000),
              FlSpot(6, 15000),
            ],
            isCurved: true,
            color: Colors.blue,
            barWidth: 3,
            dotData: FlDotData(
              show: false, // Hide dots initially
            ),
            belowBarData: BarAreaData(
              show: false, // No shaded area for a clean background
            ),
          ),
          // Previous week's expenses line
          LineChartBarData(
            spots: [
              FlSpot(0, 2000),
              FlSpot(1, 4000),
              FlSpot(2, 6000),
              FlSpot(3, 7000),
              FlSpot(4, 10000),
              FlSpot(5, 8000),
              FlSpot(6, 13000),
            ],
            isCurved: true,
            color: Colors.grey,
            barWidth: 2,
            dotData: FlDotData(
              show: false, // No dots for the previous week
            ),
            belowBarData: BarAreaData(
              show: false, // No shaded area
            ),
          ),
        ],
        minY: 0,
        maxY: 20000,
      ),
    );
  }

  // Chart Section with Combined Dropdown and Chart
  Widget _buildChartSection() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Expenses Overview',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              _buildSortingDropdown(),
            ],
          ),
          SizedBox(height: 16),
          Container(
            height: 200,
            child: _buildLineChart(),
          ),
        ],
      ),
    );
  }




}



