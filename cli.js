#!/usr/bin/env node
import yargs from 'yargs/yargs';        // point at the factory
import { hideBin } from 'yargs/helpers';
import fs from 'fs/promises';
import path from 'path';
import { fileURLToPath } from 'url';

// Get the directory where this script is located
const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

// Function to copy directory recursively
async function copyDirectory(src, dest) {
  try {
    // Create destination directory if it doesn't exist
    await fs.mkdir(dest, { recursive: true });
    
    // Read source directory
    const entries = await fs.readdir(src, { withFileTypes: true });
    
    for (const entry of entries) {
      const srcPath = path.join(src, entry.name);
      const destPath = path.join(dest, entry.name);
      
      if (entry.isDirectory()) {
        // Recursively copy subdirectory
        await copyDirectory(srcPath, destPath);
      } else {
        // Copy file
        await fs.copyFile(srcPath, destPath);
      }
    }
  } catch (error) {
    throw new Error(`Failed to copy directory: ${error.message}`);
  }
}

/**
 * Ensure that a given list of sub‑directories exists under a parent directory.
 * It creates them recursively if they are missing.
 *
 * @param {string} parentDir - The base directory where the sub‑folders should live.
 * @param {string[]} subdirs - An array of folder names to create.
 */
async function ensureSubdirectories(parentDir, subdirs) {
  for (const dir of subdirs) {
    const dirPath = path.join(parentDir, dir);
    await fs.mkdir(dirPath, { recursive: true });
  }
}

yargs(hideBin(process.argv))            // ← call the factory once
  .command(
    'setup',
    'initialise rules and tasks for Cursor',
    () => {},                           // builder (optional)
    async () => {
      try {
        console.log(`Setting up rules and tasks for Cursor`);
        
        // Source paths: rules and tasks folders relative to this script
        const rulesSourcePath = path.join(__dirname, '.cursor', 'rules');
        const tasksSourcePath = path.join(__dirname, '.tasks');
        
        // Destination paths: .cursor/rules and .tasks in current working directory
        const rulesDestPath = path.join(process.cwd(), '.cursor', 'rules');
        const tasksDestPath = path.join(process.cwd(), '.tasks');
        
        // Check if source folders exist
        try {
          await fs.access(rulesSourcePath);
        } catch (error) {
          console.error(`Error: Rules folder not found at ${rulesSourcePath}`);
          process.exit(1);
        }
        
        try {
          await fs.access(tasksSourcePath);
        } catch (error) {
          console.error(`Error: Tasks folder not found at ${tasksSourcePath}`);
          process.exit(1);
        }
        
        console.log(`Copying rules from ${rulesSourcePath} to ${rulesDestPath}...`);
        
        // Copy the rules directory
        await copyDirectory(rulesSourcePath, rulesDestPath);
        
        console.log(`✅ Successfully copied rules to ${rulesDestPath}`);
        
        console.log(`Copying tasks from ${tasksSourcePath} to ${tasksDestPath}...`);
        
        // Copy the tasks directory
        await copyDirectory(tasksSourcePath, tasksDestPath);
        
        // Ensure default task buckets exist so they are present even if npm stripped empty folders
        await ensureSubdirectories(tasksDestPath, ['0-draft', '1-now', '2-next', '3-later', '9-done']);
        console.log(`✅ Ensured task bucket folders (0-draft, 1-now, 2-next, 3-later, 9-done)`);
        
        console.log(`✅ Successfully copied tasks to ${tasksDestPath}`);
        console.log(`Rules are now available in .cursor/rules/`);
        console.log(`Tasks are now available in .tasks/`);
        
      } catch (error) {
        console.error(`❌ Error setting up rules and tasks: ${error.message}`);
        process.exit(1);
      }
    }
  )
  .demandCommand()
  .help()
  .parse();                             // or .argv