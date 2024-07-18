# 🌏 Earth -   영상으로 남기는 매일의 기억 

<p align="center"><img src="https://github.com/OneMoreThink/Earth/assets/121593683/b99d3d37-b9df-4914-821f-b62c4e239881>" width="200" height="200"/><p>

<p align="center">
  <a href="https://apps.apple.com/kr/app/earth-%EC%98%81%EC%83%81-%EB%8B%A4%EC%9D%B4%EC%96%B4%EB%A6%AC/id6520386070">
    <img src="https://github.com/OneMoreThink/Earth/assets/121593683/0193bc32-c702-42f5-9549-cca277d63870" width="200" height="80" alt="app store">
  </a>
</p>



## 앱 소개 
<div style="text-align: center;">
  <table style="width: 100%; table-layout: fixed; margin: 0 auto;">
    <tr>
      <td style="text-align: center; padding: 30px;">
        <h3>온보딩 화면</h3>
      </td>
      <td style="text-align: center; padding: 30px;">
        <h3>영상 촬영 화면</h3>
      </td>
      <td style="text-align: center; padding: 30px;">
        <h3>피드 화면</h3>
      </td>
      <td style="text-align: center; padding: 30px;">
        <h3>달력 화면</h3>
      </td>
      <td style="text-align: center; padding: 30px;">
        <h3>날짜별 영상 화면</h3>
      </td>
    </tr>
    <tr>
      <td style="text-align: center; padding: 30px;">
        <img src="https://github.com/OneMoreThink/Earth/assets/121593683/1dcf4de3-7fa7-432c-af78-0d6d6066978d" width="200" alt="Image 1">
      </td>
      <td style="text-align: center; padding: 30px;">
        <img src="https://github.com/OneMoreThink/Earth/assets/121593683/1ab947cd-a111-483f-9978-563dd8d23fb2" width="200" alt="Image 2">
      </td>
      <td style="text-align: center; padding: 30px;">
        <img src="https://github.com/OneMoreThink/Earth/assets/121593683/4f56f164-e7e3-4ca7-bc54-dc30de3870a7" width="200" alt="Image 3">
      </td>
      <td style="text-align: center; padding: 30px;">
        <img src="https://github.com/OneMoreThink/Earth/assets/121593683/ecc1da76-7cae-41b4-81c8-1b3ded0008d8" width="200" alt="Image 4">
      </td>
      <td style="text-align: center; padding: 30px;">
        <img src="https://github.com/OneMoreThink/Earth/assets/121593683/8e2a68a9-6045-40bf-a216-7808e12c39f4" width="200" alt="Image 5">
      </td>
    </tr>
  </table>
</div>


## 구조도 📜

### Entity 

![image 7](https://github.com/user-attachments/assets/e6256e75-79b4-443d-a96a-3359fc2b5170)

- xcdatamodel: PostEntity 
  - id: 엔티티간 구분
  - createdAt: 생성일을 통한 정렬 및 달력상 매핑 
  - videoURl: FileManager를 통해 저장된 동영상 위치

- Entity Codgen Manual/None 선택시 
  - PostEntity + CoreDataClass : 개발자가 Entity에 대한 custom method 작성 가능, 이후 엔티티 속성이 변경되어도 해당 파일은 보존 
  - PostEntity + CoreDataProperties : Entity의 attribute을 property로 매핑해줌 , 속성 변경시 자동생성
 
- PersistentController
  - 전체 데이터 모델을 관리하는 NSPersistentContainer를 초기화
    - xcdatamodel에서 설정한 ManagedDataModel(schema)를 Persistent store Coordinator를 이용 Store(sqlite)에 설정
    - NSPersistentStoreDescription를 이용 Store 세부 옵션 설정

- CoreDataManager
  - PersistentContainer로부터 mainContext(viewContext)를 가져와 엔티티를 관리
  - mainContext를 통해 create entity, dirty checking, lazy loading(faluting), flushing을 통해 저장로직을 최적화
  - store에 쿼리를 보내기 위해서는 대상이 되는 entity에 대한 NSFetchRequest를 구성
  - NSPredicate를 통해 복잡한 쿼리를 구성해 세부 fetch가 가능

### Model 
- Post
  - Persistent 계층과 분리를 위해서 Application 계층에서 사용될 별도의 model을 구성
  - 해당 model은 static 메서드를 통해 PostEntity를 변환
  - model로 변환시 AVPlayer를 초기화해 프로퍼티로 저장 

<p align="center">
<img src="https://github.com/user-attachments/assets/cc8c61c1-8fc4-4ea1-b641-a565e7bd3e74" width="800">
</p>



