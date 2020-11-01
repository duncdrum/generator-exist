exports.first_install = function () {
  // const Dockerode = require("dockerode")
  // const glob = require('glob')
  // const docker = new Docker()
  const exec = require("child_process").spawnSync

  buildImage({
    exec('docker', ['build', '.'], (error, stdout, stderr) => {
            console.log(`stdout: ${stdout}`)
  }
  )
}

// describe('generator test', () => {
//   let mockedCreateEnv;
//   before(() => {
//    [mockedCreateEnv = sinon
//         .stub(helpers, 'createEnv')
//         .returns(Environment.createEnv);] // uses the dependent Environment version or a custom builder
//   });
//   after(() => {
//     [mockedCreateEnv.restore();] // switch cwd back to the pre-build cwd
//     [mockedCreateEnv.cleanup();] // switch cwd back to the pre-build cwd and delete the test directory
//   });
//   describe('test', () => {
//     let runResult;
//     beforeEach(() => helpers
//       .create(                   // instantiates RunContext
//         'namespace',             // namespace or generator
//         {},                      // test options
//         {}                       // environment options
//       )
//      [.cd(dir)]                  // runs the test inside a non temporary dir
//      [.doInDir(dir => {})        // prepares the test dir
//      [.withGenerators([])]       // registers additional generators
//      [.withLookups({})]          // runs Environment lookups
//      [.withOptions({})]          // passes options to the generator
//      [.withLocalConfig({})]      // sets the generator config as soon as it is instantiated
//      [.withPrompts()]            // simulates the prompt answers
//      [.build(runContext => {     // instantiates Environment/Generator
//        [runContext.env...]       // does something with the environment
//        [runContext.generator...] // does something with the generator
//      })]
//       .run()                     // runs the environment, promises a RunResult
//       .then(result => {
//         runResult = result;
//         [result.create().run()] // instantiates a new RunContext at the same directory
//       });
//     );
//     afterEach(() => {
//       runResult.restore();
//     });
//     it('runs correctly', () => {
//       // runs assertions using mem-fs.
//       [runResult.assertFile('file.txt');]
//       [runResult.assertNoFile('file.txt');]
//       [runResult.assertFileContent('file.txt', 'content');]
//       [runResult.assertEqualsFileContent('file.txt', 'content');]
//       [runResult.assertNoFileContent('file.txt', 'content');]
//       [runResult.assertJsonFileContent('file.txt', {});]
//       [runResult.assertNoJsonFileContent('file.txt', {});]
//     });
//   });
// });