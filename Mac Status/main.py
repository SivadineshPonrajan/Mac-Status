import pyscreenshot as ImageGrab
import tkinter as tk
from tkinter import messagebox
from pynput import keyboard
import json

# Define a set to track keys currently pressed
pressed_keys = set()

def take_screenshot():
    path = "./data/"
    # Grab fullscreen
    im = ImageGrab.grab()
    # Save image file
    im.save(path+'screenshot.png')
    status = {"status": "3"}
    with open(path+"data.json", 'w') as status_file:
        json.dump(status, status_file)
    # show_popup("Screenshot", "Screenshot saved as 'screenshot.png'!")

def show_popup(title, message):
    # Create a simple Tkinter window
    root = tk.Tk()
    root.withdraw()  # Hide the main window
    # Show a message box
    messagebox.showinfo(title, message)
    # Close the Tkinter window
    root.destroy()

def stop_program():
    show_popup("Program Stopped", "The program has been terminated.")
    # Terminate the program
    listener.stop()

def on_press(key):
    try:
        # Add the pressed key to the set
        pressed_keys.add(key)

        # Check for Control + C
        if keyboard.Key.ctrl_l in pressed_keys or keyboard.Key.ctrl_r in pressed_keys:
            if key == keyboard.KeyCode.from_char('c'):
                print("Screenshot taken!")
                take_screenshot()

        # Check for Control + V
        if keyboard.Key.ctrl_l in pressed_keys or keyboard.Key.ctrl_r in pressed_keys:
            if key == keyboard.KeyCode.from_char('v'):
                print("Program stopped.")
                stop_program()
                
    except AttributeError:
        pass

def on_release(key):
    # Remove the released key from the set
    if key in pressed_keys:
        pressed_keys.remove(key)

# Start listening for key presses
with keyboard.Listener(on_press=on_press, on_release=on_release) as listener:
    print("Program started.")
    listener.join()
