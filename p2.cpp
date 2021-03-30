#include <iostream>
#include <Windows.h>
#include <iostream>

using namespace std;

int main()
{
	setlocale(LC_ALL, "Russian");
	byte arr[4] = { 0x36,0x6D,0x7F,0xBE };
	cout << "Исходные данные: ";
	for (int i = 0; i < 4; i++) {
		for (int j = 7; j >= 0; j--) cout << ((arr[i] >> j) & 1);
		cout << " ";
		if (arr[i] % 2 == 0) {
			arr[i] <<= 1;
		}
		else {
			arr[i] >>= 1;
		}
	}
	cout << "\nРезультат:       ";
	for (int i = 0; i < 4; i++) {
		for (int j = 7; j >= 0; j--) cout << ((arr[i] >> j) & 1);
		cout << " ";
	}
	cout << "\n";
	system("pause");
}
