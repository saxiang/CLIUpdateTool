import ArgumentParser
import Foundation

let version : String = "1.0.1"
let date : String = "20230428"
let authors : String = "ChenZhanXiang"

let pgyAppKey : String = "5b3b6d888d001985cc1eef5f70733ef5"

@main
class swiftCLIUpdateTool: ParsableCommand {
    static var configuration = CommandConfiguration(abstract: "凤凰秀自动打包上传pgy 工具, 第一次需要配置相关文件的路径(pgykey已硬编码配置), 后续会询问是否使用上次保存的路径配置,输入非y 则会清空之前保存的所有路径配置")
    @Argument(help: "项目路径")
    var projectPath: String = {
        if let path = UserDefaults.standard.object(forKey: "projectPath") as? String {
            return path
        }
        else {
            return ""
        }
    }()
    @Argument(help: "打包configuration \"Debug\", \"Release\"")
    var config: String = {
        if let config = UserDefaults.standard.object(forKey: "configuration") as? String {
            return config
        }
        else {
            return ""
        }
    }()
    
    @Argument(help: "exportOptionsPlist 的路径")
    var exportOptionsPlist: String = {
        if let path = UserDefaults.standard.object(forKey: "exportOptionsPlist") as? String {
            return path
        }
        else {
            return ""
        }
    }()
    
    @Argument(help: "上传蒲公英的描述")
    var description: String = "update by swift command line tool"
    
    required init() {
    }

    func removeCache() {
        UserDefaults.standard.removeObject(forKey: "projectPath")
        UserDefaults.standard.removeObject(forKey: "configuration")
        UserDefaults.standard.removeObject(forKey: "exportOptionsPlist")
        print("已清除路径配置缓存记录!")
    }
    
    func run() {
        print("\n\n")
        print("|======================================|")
        print("|🎉🎉🎉🎉🎉🎉🎉🎉🎉🎉🎉🎉🎉🎉🎉🎉🎉🎉🎉|")
        print("|🎉👏🏻👏🏻👏🏻👏🏻👏🏻👏🏻👏🏻👏🏻👏🏻👏🏻👏🏻👏🏻👏🏻👏🏻👏🏻👏🏻👏🏻🎉|")
        print("|🎉🌹🌹🌹🌹🌹🌹🌹🌹🌹🌹🌹🌹🌹🌹🌹🌹🌹🎉|")
        print("|🎉🌹👏🏻欢迎使用凤凰秀自动打包工具👏🏻🌹🎉|")
        print("|🎉🌹🌹🌹🌹🌹🌹🌹🌹🌹🌹🌹🌹🌹🌹🌹🌹🌹🎉|")
        print("|🎉👏🏻👏🏻👏🏻👏🏻👏🏻👏🏻👏🏻👏🏻👏🏻👏🏻👏🏻👏🏻👏🏻👏🏻👏🏻👏🏻👏🏻🎉|")
        print("|🎉🎉🎉🎉🎉🎉🎉🎉🎉🎉🎉🎉🎉🎉🎉🎉🎉🎉🎉|")
        print("|     version: \(version) date: \(date)    |")
        print("|        authors: \(authors)        |")
        print("|======================================|")
        print("\n\n")
        
        var isUseCache : Bool = false
        if projectPath.count > 0 {
            print("检测到有路径配置缓存,是否使用缓存信息? (y/n)")
            let useCache = readLine()
            if useCache == "y" || useCache == "Y" {
                isUseCache = true
            }
            else {
                isUseCache = false
                removeCache()
            }
        }
        
        if !isUseCache || projectPath.count < 1 {
            var reEnter : Bool = true
            while reEnter == true {
                print("请输入项目路径! exp: /Users/CZX/Desktop/FengShows")
                let path = readLine()
                if let readPath = path, readPath.count > 0 {
                    projectPath = readPath
                    UserDefaults.standard.set(projectPath, forKey: "projectPath")
                    reEnter = false
                }
                else {
                    reEnter = true
                    print("项目路径输入有误,请重新输入!")
                }
            }
        }
        
        if !isUseCache || config.count < 1 {
            var reEnter : Bool = true
            while reEnter == true {
                print("请输入configuration! exp: Debug,Release (区分大小写)")
                let rConfig = readLine()
                if let readConfig = rConfig, (readConfig == "Debug" || readConfig == "Release") {
                    config = readConfig
                    UserDefaults.standard.set(config, forKey: "configuration")
                    reEnter = false
                }
                else {
                    reEnter = true
                    print("congfig输入有误,请重新输入!")
                }
            }
        }
        
        if !isUseCache || exportOptionsPlist.count < 1 {
            var reEnter : Bool = true
            while reEnter == true {
                print("请输入exportOptionsPlist路径. exp: /Users/CZX/ExportOptions.plist")
                let pPath = readLine()
                if let readPath = pPath, readPath.count > 0 {
                    exportOptionsPlist = readPath
                    UserDefaults.standard.set(exportOptionsPlist, forKey: "exportOptionsPlist")
                    reEnter = false
                }
                else {
                    reEnter = true
                    print("路径输入有误,请重新输入!")
                }
            }
        }
        
        print("请输入上传蒲公英描述!")
        let descriptionStr = readLine()
        if let desc = descriptionStr, desc.count > 0 {
            description = desc
        }
        
        print("\n 用户输入配置信息内容:\n 项目路径:\(projectPath)\n 打包configuration:\(config)\n exportOptionsPlist路径:\(exportOptionsPlist)\n 上传pgy描述:\(description)\n")

//        // 解析外部传进来的参数
//        let arguments = CommandLine.arguments
//        print("打印哦: \(arguments)")
//
//        if arguments.count >= 2 {
//            let path = arguments[1]
//            guard path.count > 0 else {
//                print("参数传入错误\n")
//                return
//            }
//            projectPath = path
//            UserDefaults.standard.set(projectPath, forKey: "projectPath")
//            print("入参: \(path)")
//        }
//
//        if arguments.count >= 3 {
//            let cg = arguments[2]
//            guard config.count > 0 else {
//                print("参数传入错误\n")
//                return
//            }
//            config = cg
//            UserDefaults.standard.set(config, forKey: "configuration")
//            print("入参: \(cg)")
//        }
//
//        if arguments.count >= 4 {
//            let plistPath = arguments[3]
//            guard plistPath.count > 0 else {
//                print("参数传入错误\n")
//                return
//            }
//            exportOptionsPlist = plistPath
//            UserDefaults.standard.set(exportOptionsPlist, forKey: "exportOptionsPlist")
//            print("入参: \(plistPath)")
//        }

        do{
            let ipaTool = try IpaTool(projectPath: projectPath,
                                      configuration: config,
                                      exportOptionsPlist: exportOptionsPlist,
                                      pgyerKey: pgyAppKey,
                                      updateDescription:description
            )

            /*
            var output = ipaTool.podInstall()
            print(output.readData)
            exit(-1)
            print(ipaTool)
            print("执行clean")
            */
            var output = ipaTool.clean()
            if output.readData.count > 0 {
                print("执行失败clean error = \(output.readData)")
                swiftCLIUpdateTool.exit(withError: -1 as? Error)
            }
            print("执行archive")
            output = ipaTool.archive()
            if !FileManager.default.fileExists(atPath: ipaTool.xcarchive) {
                print("执行失败archive error = \(output.readData)")
//                exit(-1)
                swiftCLIUpdateTool.exit(withError: -1 as? Error)
            }
            print("执行exportArchive")
            output = ipaTool.exportArchive()

            if !FileManager.default.fileExists(atPath: ipaTool.exportIpaPath.appPath("\(ipaTool.scheme).ipa")) {
                print("执行失败exportArchive error =\(output.readData)")
//                exit(-1)
                swiftCLIUpdateTool.exit(withError: -1 as? Error)
            }
            print("导出ipa成功\(ipaTool.exportIpaPath)")
            print("开始上传蒲公英\n")
            ipaTool.update()
        }catch{
            print(error)
        }
    }
}
